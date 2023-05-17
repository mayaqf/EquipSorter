local _jobs = require "resources.jobs"
_jobs[8388606] = {id=8388606,en="All jobs",ja="All Jobs",ens="ALL",jas="ALL"}

local jobs = {res = _jobs}

function jobs.get_jobs(id)
    if type(id) ~= "number" then return "nil" end
    if id == _jobs[8388606].id then return "All Jobs" end
    local js = ""
    for _, v in pairs(_jobs) do
        if ((id >> v.id ) & 1) == 1 then js = js..v.jas end
    end
    return js
end

function jobs.get_job_id(job)
    for i,v in pairs(_jobs) do
        if v.en == job or v.ja == job or v.ens == job or v.jas == job then
            return 1 << v.id
        end
    end
    return nil
end

return jobs
