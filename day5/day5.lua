
function read_maze()
    local maze = {}
    while true do
        local ins = tonumber(io.read ())
        if (not ins) then break end
        table.insert (maze, ins)
    end
    -- Convert offsets to absolute address
    for i,v in ipairs(maze) do
        maze[i] = maze[i] + i
    end
    return maze
end

function escape_from_maze(maze, mutation)
    local steps = 0
    local i = 1
    while true do
        if i > #maze then break end
        if i < 1 then break end
        local last = i
        i = maze[i]
        mutation (maze, last, i)
        steps = steps + 1
    end
    return steps
end

function part1 (maze, lasti, i)
    maze[lasti] = maze[lasti] + 1
end

function part2 (maze, lasti, i)
    if i - lasti >= 3 then
        maze[lasti] = maze[lasti] - 1
    else
        part1 (maze, lasti, i)
    end
end

print (escape_from_maze (read_maze(), part2))
