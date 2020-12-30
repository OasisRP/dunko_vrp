local MySQL = {}
local Queries = {}

function MySQL.createCommand(queryname, query)
    if not Queries[queryname] then 
        Queries[queryname] = query
    else 
        print('VRP_DB_DRIVER: Error query already exists.')
    end 
end

function MySQL.execute(queryname, variables)
    if Queries[queryname] then 
        if variables then 
            exports['ghmattimysql']:execute(Queries[queryname], variables)
        else 
            exports['ghmattimysql']:execute(Queries[queryname])
        end 
    else 
        print('VRP_DB_DRIVER: Error query does not exist!')
    end 
end

function MySQL.query(queryname, variables, cb)
    if Queries[queryname] then 
        if variables then 
            print(Queries[queryname])
            exports['ghmattimysql']:execute(Queries[queryname], variables, function(rows, affected)
                print('GHMATTI', json.encode(rows))
                cb(rows, affected)
            end)
        end 
    else 
        print('VRP_DB_DRIVER: Error query does not exist!')
        cb({{},nil})
    end 
end


function MySQL.SingleQuery(query)
    exports['ghmattimysql']:execute(query)
end

return MySQL