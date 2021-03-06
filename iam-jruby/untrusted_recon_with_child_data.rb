require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
id = ARGV[0]
objName = 'testrecon'
 
jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})
 
xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('xelsysadm', 'password')

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

#reconIntf = xlclient.getUtility('recon')
reconIntf = xlclient.getUtility('reconsvc')

reconHash = {
    'itres' => '5',
    'login' => id,
    'age' => id.to_s + 'modified'
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, false)

# first child table entry
childHash = {
    'entname' => '5~ron',
    'entdesc' => 'testronb'
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'recchld', childMap)

# second child table entry
childHash = {
    'entname' => '5~harry',
    'entdesc' => 'helloharry'
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'recchld', childMap)

reconIntf.finishReconciliationEvent(rceKey)

reconIntf.callingEndOfJobAPI()

puts "Created recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
