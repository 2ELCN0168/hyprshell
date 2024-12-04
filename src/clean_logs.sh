function clean_logs()
{
        command rm -rf "../out/log"*".log" 1> "/dev/null" 2>&1
}
