function lovr.load()
  local long = string.rep('a', 2000) .. '.txt'
  local file, err = lovr.filesystem.newFile(long, 'r')
  assert(not file and err)

  local missing = 'does/not/exist.txt'
  local file, err = lovr.filesystem.newFile(missing, 'r')
  assert(not file and err)
  local file, err = lovr.filesystem.newFile(missing, 'w')
  assert(not file and err)

  local file, err = lovr.filesystem.newFile('test.txt', 'w')
  assert(file and not err)
  assert(file:write('hi'))
  file:release()
  assert(lovr.filesystem.read('test.txt') == 'hi')

  assert(lovr.filesystem.write('test.txt', 'hi'))
  local file, err = lovr.filesystem.newFile('test.txt', 'r')
  assert(file and not err)
  assert(file:getMode() == 'r')
  assert(file:getPath() == 'test.txt')
  assert(file:getSize() == 2)
  local data, size = file:read()
  assert(data == 'hi' and size == 2)
  file:release()

  assert(lovr.filesystem.isDirectory('dir') or lovr.filesystem.createDirectory('dir'))
  local file, err = lovr.filesystem.newFile('dir', 'r')
  assert(not file and err)
  local file, err = lovr.filesystem.newFile('dir', 'w')
  assert(not file and err)
  assert(lovr.filesystem.remove('dir'))

  assert(lovr.filesystem.write('test.txt', 'hi'))
  local file, err = lovr.filesystem.newFile('test.txt', 'r')
  assert(file and not err)
  assert(file:isEOF() == false)
  assert(file:tell() == 0)
  assert(file:seek(1))
  assert(file:tell() == 1)
  assert(file:read(1) == 'i')
  assert(file:tell() == 2)
  assert(file:isEOF() == true)

  assert(file:seek(1000000))
  assert(file:tell() == 1000000)
  assert(file:read(1000000) == '')
  assert(file:isEOF() == true)

  assert(pcall(file.seek, file, -1) == false)
  assert(pcall(file.seek, file, 2^53 - 1) == true)
  assert(pcall(file.seek, file, 2^53) == false)

  assert(file:seek(0))
  assert(file:read(2) == 'hi')
  assert(file:tell() == 2)
end

lovr.event.quit()
