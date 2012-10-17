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
if [ `tty` = 'v0' ]; then
	eval `ssh-agent`
	ssh-add
fi
