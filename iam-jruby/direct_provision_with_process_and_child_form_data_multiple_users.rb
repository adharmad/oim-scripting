require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'KODAK'
count = 10
objName = 'SIMRES'

parentFormName = 'UD_SIMRESP'
childForms = ['UD_SIMRESC1', 'UD_SIMRESC2']

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')
fiIntf = xlclient.getUtility('fi')

for idx in (1..count)

    usrLogin = usrPrefix + idx.to_s

    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)

    t1 = System.currentTimeMillis
    oiuKey = usrIntf.provisionObject(usrKey, objKey)

    # get the objects provisioned to the user
    rs = usrIntf.getObjects(usrKey)
    orcKey = 0
    for i in (0..rs.getRowCount-1)
        rs.goToRow i
        oiuKeyFromRS = rs.getLongValue "Users-Object Instance For User.Key"

        if oiuKeyFromRS == oiuKey
            orcKey = rs.getLongValue "Process Instance.Key"
            #puts "Got orcKey = #{orcKey}"
        end
    end

    # set process form data
    udHash = {
        parentFormName + '_ITRES' => '24',
        parentFormName + '_F1' => usrLogin + '_test_data_hello',
        parentFormName + '_F2' => usrLogin + '_another_test_data_hello'
    }

    udMap = HashMap.new(udHash)
    fiIntf.setProcessFormData(orcKey, udMap)

    # fill in child form data
    for cForm in childForms
        cFormKey = xlclient.getFormKey(cForm)

        if cForm == 'UD_SIMRESC1' 
       
            udChildMap = HashMap.new({
            cForm + '_GROUP' => '5~Finance',
            cForm + '_APPLICATION' => 'Finance Application'
            })

        elsif cForm == 'UD_SIMRESC2'

            udChildMap = HashMap.new({
            cForm + '_ENTITLEMENT' => '5~General Ledger',
            cForm + '_ENTDESC' => 'General Ledger description'
            })

        end

            fiIntf.addProcessFormChildData(cFormKey, orcKey, udChildMap)

        end

    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

end

xlclient.logout
System.exit 0
