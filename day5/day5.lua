
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

function escape_from_maze_p1(maze)
    local steps = 0
    local i = 1
    while true do
        if i > #maze then break end
        if i < 1 then break end
        local last = i
        i = maze[i]
        maze[last] = maze[last] + 1
        steps = steps + 1
    end
    return steps
end

function escape_from_maze_p2(maze)
    local steps = 0
    local i = 1
    while true do
        if i > #maze then break end
        if i < 1 then break end
        local last = i
        i = maze[i]
        if i - last >= 3 then
            maze[last] = maze[last] - 1
        else
            maze[last] = maze[last] + 1
        end
        steps = steps + 1
    end
    return steps
end

print (escape_from_maze_p2 (read_maze()))
