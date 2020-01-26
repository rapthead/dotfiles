function getMoveFn(dir)
    return function()
        -- cmd = ("mv %q %q/%q"):format(mp.get_property("path"), dir, mp.get_property("filename"))
        cmd = ("mv %q `dirname %q`/%q"):format(mp.get_property("path"), mp.get_property("path"), dir)
        mp.msg.log("warn", "move to " .. dir)
        os.execute(cmd)
    end
end

mp.add_key_binding("Ctrl+Alt+g", "mark_good", getMoveFn('good'))
mp.add_key_binding("Ctrl+Alt+l", "mark_live", getMoveFn('live'))
mp.add_key_binding("Ctrl+Alt+s", "mark_street", getMoveFn('street'))
