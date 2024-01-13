DEBUG = true;

function dbg(...)
    if AltTab.DEBUG then
        Debug.console("[AltTab] "..unpack(arg))
    end
end

function CommOut(...)
    MsgData = {}
    MsgData["text"] = unpack(arg)
    Comm.addChatMessage(MsgData)
end

function AltTabHandler(sCommands, sParams)
    AltTab.dbg("++AltTabHandler( sCommands=["..sCommands.."], sParams=["..sParams.."] )");
    nParam = tonumber(sParams)
    if (nParam == nil) then nParam = 1 end
    AltTab.dbg("  nParam = ["..nParam.."]")
    WndList = Interface.getWindows()
    if (nParam == 0) then
        AltTab.CommOut("=== LISTING WINDOWS ===")
        AltTab.CommOut("[id] [title] [class]")
        AltTab.CommOut("=======================")
        for i,wnd in pairs(WndList) do
            wndclass = wnd.getClass()
            if wndclass == "desktopdecal" then return end
            wndnode = wnd.getDatabaseNode()
            if wndnode ~= nil then
                wndtitle = wndnode.getName()
                wndtitlenode = wndnode.getChild("name")
                if wndtitlenode ~= nil then
                    wndtitle = wndtitlenode.getValue()
                end
            end
            AltTab.CommOut("["..i.."] ["..wndtitle.."] ["..wndclass.."]")
        end
    else
        wndclass = WndList[nParam].getClass()
        AltTab.dbg("  calling WndList["..nParam.."].bringToFront, class=["..wndclass.."]")
        WndList[nParam].bringToFront()
    end
    AltTab.dbg("--AltTabHandler(): last");
end

function onInit()
    AltTab.dbg("++AltTab::OnInit()")
    Comm.registerSlashHandler("alttab",AltTabHandler);
    AltTab.dbg("--AltTab::OnInit(): last");
end