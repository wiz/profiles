# list users on server, not laptop
case `uname` in
	FreeBSD)
		w -n
		;;
	Darwin)
		;;
	*)
		w
		;;
esac
