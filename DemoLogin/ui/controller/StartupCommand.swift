//
//  StartupCommand.swift
//  TriggerBangIos
//
//  Created by Mark on 2019/8/30.
//  Copyright © 2019 Mark. All rights reserved.
//

public class StartupCommand : MacroCommand {
    
    /**
     Add the Subcommands to startup the PureMVC apparatus.
     
     Generally, it is best to prep the Model (mostly registering
     proxies) followed by preparation of the View (mostly registering
     Mediators).
     */
    override public func initializeMacroCommand() {
        addSubCommand { InitProxyCommand() }
        addSubCommand { InitViewCommand() }
    }
}
