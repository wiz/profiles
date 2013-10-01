# list users on server, not laptop
case `uname` in
	FreeBSD)
		=w -n
		;;
	Darwin)
		;;
	*)
		w
		;;
esac

# when logging into desktop, start ssh agent
if [ `hostname` = 'j.local' ] && [ `tty` = '/dev/ttyv0' ]; then
	mixer vol 20
	eval `ssh-agent`
	ssh-add
fi
