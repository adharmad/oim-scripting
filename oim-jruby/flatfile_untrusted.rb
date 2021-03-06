require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


resName = 'account1'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

File.open('c:/tmp/accdata.txt', 'r') do |f1|
    while line = f1.gets
        toks = line.split(',')

        reconHash = {
            'uid' => toks[0].strip,
            'first' => toks[1].strip,
            'last' => toks[2].chomp.strip,
        }        
        
        reconMap = HashMap.new(reconHash)

        if not reconIntf.ignoreEvent(resName, reconMap)
            t1 = System.currentTimeMillis
            rceKey = reconIntf.createReconciliationEvent(resName, reconMap, true)
            t2 = System.currentTimeMillis
            delta = t2-t1
            puts "Created recon event with key = #{rceKey} time = #{delta}"
        else
            puts "Event is ignored"
        end
    end
end

xlclient.close
System.exit 0
