def trust(path)
  sh("sudo sqlite3 \"/Library/Application\ Support/com.apple.TCC/TCC.db\" \"DELETE FROM access WHERE client='#{path}';\"")
  sh("sudo sqlite3 \"/Library/Application\ Support/com.apple.TCC/TCC.db\" \"INSERT or REPLACE INTO access values ('kTCCServiceAccessibility', '#{path}', 0, 1, 0, NULL);\"")
end

desc "Trust App"
task :trust_app do
  puts "Trusting App: NOTICE! You cannot trust apps from mounted volumes (encfs)."
  trust("com.foo.foo")
  trust("com.foo.foo_spec")
end
