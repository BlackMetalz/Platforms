- Location of check-mk-agent plugin:
`
/usr/lib/check_mk_agent/plugins
`

Place missing plugin in there in order to fix warn/error like this:
`
WARN - [agent] Version: 1.2.6p12, OS: linux, Missing agent sections: logwatch, execution time 0.4 sec
`
More Information related to this error: this error has been fixed in check mk agent 1.6 and bugged in version 1.5.0p19.

- Get local plugin in check_mk_agent:
`
check_mk_agent | grep -v grep | grep -A 3 "<<<local>>>"
`
