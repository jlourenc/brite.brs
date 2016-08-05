sub runBriteLoggerExample()
    BriteLogger().setLevel(BriteLogger().LEVEL.ALL)

    for i=0 to 3 step 1
        generateErrorLogs(i)
        generateWarningLogs(i+1)
        generateInfoLogs(i*i)
        generateDebugLogs(i*i*i)
    end for
end sub

sub generateErrorLogs(n as Integer)
    for i=0 to n step 1
        sleep(i*321)
        BriteLogger().error("TAG1", "This is an error message {0}", BriteEvent("type", i))
    end for
end sub

sub generateWarningLogs(n as Integer)
    for i=0 to n step 1
        sleep(i*123)
        BriteLogger().warning("TAG2", "This is a warning message: {0} * {1} = {2}", [i,i,i*i])
    end for
end sub

sub generateInfoLogs(n as Integer)
    for i=0 to n step 1
        sleep(i*23)
        BriteLogger().info("TAG3", "This is the info message number {0}", i)
    end for
end sub

sub generateDebugLogs(n as Integer)
    for i=0 to n step 1
        sleep(i*12)
        BriteLogger().debug("TAG4", "This is a debug message")
    end for
end sub
