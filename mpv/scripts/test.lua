function test()
    mp.osd_message("audio="..mp.get_property("current-ao"))
end

mp.add_key_binding("Ctrl+Alt+t", "test", test)
