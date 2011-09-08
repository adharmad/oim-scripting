export JAVA_HOME=
export XLHOME=
export JRUBY_HOME=
export OIM_SERVER=


CLASSPATH=".:$OIM_SERVER/server/ext/internal/eclipselink.jar:$OIM_SERVER/server/platform/iam-platform-entitymgr.jar:$OIM_SERVER/server/platform/iam-platform-authz-service.jar:$XLHOME/lib/oimclient.jar:$XLHOME/lib/iam-platform-auth-client.jar:$XLHOME/lib/iam-platform-utils.jar:$XLHOME/lib/iam-platform-context.jar:$XLHOME/lib/iam-platform-pluginframework.jar:$XLHOME/lib/XellerateClient.jar:$XLHOME/lib/XellerateServer.jar:$XLHOME/ext/spring.jar:$XLHOME/ext/security-api.jar:$XLHOME/ext/commons-logging.jar:$XLHOME/ext/logging-utils.jar:$XLHOME/ext/jakarta-oro-2.0.8.jar:$XLHOME/ext/bsh.jar:$XLHOME/ext/jhall.jar:$XLHOME/ext/mail.jar:$XLHOME/ext/log4j-1.2.8.jar:$XLHOME/ext/jboss-j2ee.jar:$XLHOME/ext/jboss-jaas.jar:$XLHOME/ext/jbosssx.jar:$XLHOME/ext/jts.jar:$XLHOME/ext/jbossall-client.jar:$XLHOME/ext/concurrent.jar:$XLHOME/ext/getopt.jar:$XLHOME/ext/gnu-regexp.jar:$XLHOME/ext/jacorb.jar:$XLHOME/ext/jboss-client.jar:$XLHOME/ext/jboss-common-client.jar:$XLHOME/ext/jbosscx-client.jar:$XLHOME/ext/jbossha-client.jar:$XLHOME/ext/jboss-iiop-client.jar:$XLHOME/ext/jbossjmx-ant.jar:$XLHOME/ext/jboss-jsr77-client.jar:$XLHOME/ext/jbossmq-client.jar:$XLHOME/ext/jboss-net-client.jar:$XLHOME/ext/jbosssx-client.jar:$XLHOME/ext/jboss-system-client.jar:$XLHOME/ext/jboss-transaction-client.jar:$XLHOME/ext/jcert.jar:$XLHOME/ext/jmx-connector-client-factory.jar:$XLHOME/ext/jmx-ejb-connector-client.jar:$XLHOME/ext/xdoclet-module-jboss-net.jar:$XLHOME/ext/jsse.jar:$XLHOME/ext/jnet.jar:$XLHOME/ext/jmx-rmi-connector-client.jar:$XLHOME/ext/jmx-invoker-adapter-client.jar:$XLHOME/ext/jnp-client.jar:$XLHOME/ext/log4j.jar:$XLHOME/ext/jocache.jar:$XLHOME/lib/xlAPI.jar:$XLHOME/lib/xlLogger.jar:$XLHOME/lib/xlVO.jar:$XLHOME/lib/xlUtils.jar:$XLHOME/lib/xlCrypto.jar:$XLHOME/lib/xlAuthentication.jar:$XLHOME/lib/xlDataObjectBeans.jar:$XLHOME/ext/wlfullclient.jar:$XLHOME/lib/xlCopyUtil.jar:$XLHOME/ext/xalan.jar:$XLHOME/ext/xerces.jar:$XLHOME/ext/xercesImpl.jar:$XLHOME/ext/oc4jclient.jar:$XLHOME/ext/ejb.jar:$XLHOME/ext/oscache.jar:$XLHOME/ext/commons-logging.jar:$XLHOME/ext/javagroups-all.jar:$CLASSPATH"
export CLASSPATH

export JAVA_OPTS="-DXL.HomeDir=$OIM_SERVER/server -Djava.security.auth.login.config=$XLHOME/config/authwl.conf"
$JRUBY_HOME/bin/jruby $1
