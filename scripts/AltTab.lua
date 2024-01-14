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

function ToFront(WndList, nWindow)
    AltTab.dbg("+-ToFront(): calling WndList["..nWindow.."].bringToFront")
    WndList[nWindow].bringToFront()
    return
end

function AltTabHandler(sCommands, sParams)
    AltTab.dbg("++AltTabHandler( sCommands=["..sCommands.."], sParams=["..sParams.."] )");

    -- The window stack Z-depth seems to always have LRU as ID:1,
    -- with the MRU just above the desktopdecal
    -- When sParam is empty, MRU is bottom of the stack -1
    -- When sParam is 0, list all windows.
    -- When sParam is 1, will cycle through all windows.

    WndList = Interface.getWindows()

    nParam = tonumber(sParams)
    if (nParam == nil) then nParam = -1 end
    AltTab.dbg("  nParam = ["..nParam.."]")

    if nParam > 0 then return AltTab.ToFront(WndList, nParam) end

    LastWindow = 1
    SecondLast = 1
    sOut = "=== LISTING WINDOWS ===\n[id] [title] [class]\n======================="
    for i,wnd in pairs(WndList) do
        wndclass = wnd.getClass()
        if wndclass == "desktopdecal" then break end

        wndnode = wnd.getDatabaseNode()
        wndtitle = nil
        if wndnode ~= nil then
            wndtitle = wndnode.getName()
            wndtitlenode = wndnode.getChild("name")
            if wndtitlenode ~= nil then
                wndtitle = wndtitlenode.getValue()
            end
        end
        if wndtitle ~= nil then 
            SecondLast = LastWindow
            LastWindow = i
            sOut = sOut .. "\n["..i.."] ["..wndtitle.."] ["..wndclass.."]"
        end
    end
    if nParam < 0 then
        AltTab.ToFront(WndList, SecondLast)
    else
        AltTab.CommOut(sOut)
    end
    AltTab.dbg("--AltTabHandler(): last");
end

function onInit()
    AltTab.dbg("++AltTab::OnInit()")
    Comm.registerSlashHandler("alttab",AltTabHandler);
    AltTab.AltTabHandler("alttab","0")
    AltTab.dbg("--AltTab::OnInit(): last");
end