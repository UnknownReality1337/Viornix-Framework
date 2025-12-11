--!nonstrict
local RunService = game:GetService("RunService")
local Promise = require(game.ReplicatedStorage.Packages.Promise)

local Networking = {
	RateLimit = 60,
	MaxRemotes = 100,
	RateLimits = {},
	BindableEvents = {
		Server = {},
		Client = {}
	},
	BindableFunctions = {
		Server = {},
		Client = {}
	},
}

function Networking:ListenBindableFunction(bindable, callback)
	if RunService:IsServer() then
		if not script:FindFirstChild("BindableFuncs_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Server";
			if not Networking.BindableFunctions.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				Networking.BindableFunctions.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);
				Networking.BindableFunctions.Server[bindable].Name = bindable;
				Networking.BindableFunctions.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				Networking.BindableFunctions.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		else
			if not Networking.BindableFunctions.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				Networking.BindableFunctions.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);
				Networking.BindableFunctions.Server[bindable].Name = bindable;
				Networking.BindableFunctions.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				Networking.BindableFunctions.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		end
	elseif RunService:IsClient() then
		if not script:FindFirstChild("BindableFuncs_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Client";
			if not Networking.BindableFunctions.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				Networking.BindableFunctions.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);
				Networking.BindableFunctions.Client[bindable].Name = bindable;
				Networking.BindableFunctions.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				Networking.BindableFunctions.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		else
			if not Networking.BindableFunctions.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				Networking.BindableFunctions.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);
				Networking.BindableFunctions.Client[bindable].Name = bindable;
				Networking.BindableFunctions.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				Networking.BindableFunctions.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		end
	end
end

function Networking:InvokeBindableFunction(...)
	local args = {...}
	local bindable
	if RunService:IsClient() then
		bindable = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("BindableFuncs_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Client";
			if not Networking.BindableFunctions.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				Networking.BindableFunctions.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);

				return Networking.BindableFunctions.Client[bindable]:Invoke(unpack(args));
			else
				return Networking.BindableFunctions.Client[bindable]:Invoke(unpack(args));
			end
		else
			if not Networking.BindableFunctions.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				Networking.BindableFunctions.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);

				return Networking.BindableFunctions.Client[bindable]:Invoke(unpack(args));
			else
				return Networking.BindableFunctions.Client[bindable]:Invoke(unpack(args));
			end
		end
	elseif RunService:IsServer() then
		bindable = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("BindableFuncs_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Server";
			if not Networking.BindableFunctions.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				Networking.BindableFunctions.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);

				return Networking.BindableFunctions.Server[bindable]:Invoke(unpack(args));
			else
				return Networking.BindableFunctions.Server[bindable]:Invoke(unpack(args));
			end
		else
			if not Networking.BindableFunctions.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				Networking.BindableFunctions.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);

				return Networking.BindableFunctions.Server[bindable]:Invoke(unpack(args));
			else
				return Networking.BindableFunctions.Server[bindable]:Invoke(unpack(args));
			end
		end
	end
end

function Networking:ListenBindableEvent(bindable, callback)
	if RunService:IsClient() then
		if not script:FindFirstChild("Bindables_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Client";

			if not Networking.BindableEvents.Client[bindable] then
				warn("Bindable Event does not exist.. creating one");
				Networking.BindableEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				Networking.BindableEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				Networking.BindableEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end	
		else
			if not Networking.BindableEvents.Client[bindable] then
				warn("Bindable Event does not exist.. creating one");
				Networking.BindableEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				Networking.BindableEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				Networking.BindableEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end
		end
	elseif RunService:IsServer() then
		if not script:FindFirstChild("Bindables_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Server";

			if not Networking.BindableEvents.Server[bindable] then
				warn("Bindable Event does not exist.. creating one");
				Networking.BindableEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				Networking.BindableEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				Networking.BindableEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end	
		else
			if not Networking.BindableEvents.Server[bindable] then
				warn("Bindable Event does not exist.. creating one");
				Networking.BindableEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				Networking.BindableEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				Networking.BindableEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end
		end
	end
end

function Networking:FireBindableEvent(...)
	local args = {...}
	local bindable
	if RunService:IsClient() then
		bindable = args[1];
		table.remove(args, 1)
		if not script:FindFirstChild("Bindables_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Client";
			if not Networking.BindableEvents.Client[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				Networking.BindableEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				Networking.BindableEvents.Client[bindable]:Fire(unpack(args));
			else
				Networking.BindableEvents.Client[bindable]:Fire(unpack(args));
			end
		else
			if not Networking.BindableEvents.Client[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				Networking.BindableEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				Networking.BindableEvents.Client[bindable]:Fire(unpack(args));
			else
				Networking.BindableEvents.Client[bindable]:Fire(unpack(args));
			end
		end
	elseif RunService:IsServer() then
		bindable = args[1];
		table.remove(args, 1)
		if not script:FindFirstChild("Bindables_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Server";
			if not Networking.BindableEvents.Server[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				Networking.BindableEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				Networking.BindableEvents.Server[bindable]:Fire(unpack(args));
			else
				Networking.BindableEvents.Server[bindable]:Fire(unpack(args));
			end
		else
			if not Networking.BindableEvents.Server[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				Networking.BindableEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				Networking.BindableEvents.Server[bindable]:Fire(unpack(args));
			else
				Networking.BindableEvents.Server[bindable]:Fire(unpack(args));
			end
		end
	end
end

function Networking:ListenRemoteEvent(event: string, callback: (... any) -> ()) : any
	if RunService:IsClient() then
		return Promise.new(function(resolve, reject, onCancel)
			local remoteEvent = createEvent(event)

			if not remoteEvent then
				reject("Catastrophic failure with remote event retrieval.")
				return;
			end

			remoteEvent.OnClientEvent:Connect(function(...)
				return callback(...);
			end)
		end)
	elseif RunService:IsServer() then
		return Promise.new(function(resolve, reject, onCancel)
			local remoteEvent = createEvent(event)

			if not remoteEvent then
				reject("Catastrophic failure with remote event retrieval.")
				return;
			end

			remoteEvent.OnServerEvent:Connect(function(...)
				return callback(...);
			end)
		end)
	else
		return nil;
	end
end

function Networking:ListenRemoteFunction(func: string, callback: (... any) -> ()) : any
	if RunService:IsClient() then
		return Promise.new(function(resolve, reject, onCancel)
			local remoteFunction = createFunction(func)

			if not remoteFunction then
				reject("Catastrophic failure with remote function retrieval.")
				return;
			end

			remoteFunction.OnClientInvoke = function(...)
				return callback(...);
			end
		end)
	elseif RunService:IsServer() then
		return Promise.new(function(resolve, reject, onCancel)
			local remoteFunction = createFunction(func)

			if not remoteFunction then
				reject("Catastrophic failure with remote function retrieval.")
				return;
			end

			remoteFunction.OnServerInvoke = function(...)
				return callback(...);
			end
		end)
	else
		return nil;
	end
end

function Networking:FireEvent(...) : any
	local args = {...}
	local event, player

	if RunService:IsClient() then
		event = args[1];
		table.remove(args,  1);

		local RemoteEvent = createEvent(event);

		if not RemoteEvent then
			warn("Catastrophic failure with remote event creation.");
			return;
		end

		RemoteEvent:FireServer(unpack(args));
		return;
	elseif RunService:IsServer() then
		if typeof(args[1]) == "Instance" and args[1]:IsA("Player") then
			player = table.remove(args, 1);
		end

		event = args[1];
		table.remove(args, 1);

		local RemoteEvent = createEvent(event);

		if not RemoteEvent then
			warn("Catastrophic failure with remote event creation.");
			return;
		end

		if not player then
			return;
		end

		RemoteEvent:FireClient(player, unpack(args));
		return;
	else
		return nil;
	end
end

function Networking:InvokeRemote(...) : any
	local args = {...};
	local func, player;

	if RunService:IsClient() then
		func = args[1];
		table.remove(args, 1);

		local RemoteFunction = createFunction(func);

		if not RemoteFunction then
			warn("Catastrophic failure with remote function creation.");
			return;
		end

		return RemoteFunction:InvokeServer(unpack(args));
	elseif RunService:IsServer() then
		if typeof(args[1]) == "Instance" and args[1]:IsA("Player") then
			player = table.remove(args, 1);
		end

		func = args[1];
		table.remove(args, 1);

		local RemoteFunction = createFunction(func);

		if not RemoteFunction then
			warn("Catastrophic failure with remote function creation.");
			return;
		end

		if not player then
			return;
		end

		return RemoteFunction:InvokeClient(player, unpack(args));
	else
		return nil;
	end
end

function createEvent(name: string) : RemoteEvent?
	if RunService:IsClient() then
		if not script.Comm:FindFirstChild(name) then
			local remote = script.Comm:FindFirstChild("CreationRemote"):InvokeServer(name, "RemoteEvent")
			return remote;
		elseif script.Comm:FindFirstChild(name) and script.Comm:FindFirstChild(name):IsA("RemoteEvent") then
			return script.Comm:FindFirstChild(name)
		else
			return nil
		end
	elseif RunService:IsServer() then
		if not script:FindFirstChild("Comm") then
			local rems = Instance.new("Folder", script);
			rems.Name = "Comm";
		end

		if script.Comm:FindFirstChild(name) and not script.Comm:FindFirstChild(name):IsA("RemoteEvent") then
			warn("Remote Event name already exists as a RemoteFunction, try changing name before trying again.")
			return;
		elseif not script.Comm:FindFirstChild(name) then
			local remote = Instance.new("RemoteEvent", script.Comm)
			remote.Name = name
			return remote;
		elseif script.Comm:FindFirstChild(name) then
			return script.Comm:FindFirstChild(name)
		else
			return;
		end
	else
		return
	end
end

function createFunction(name: string) : RemoteFunction?
	if RunService:IsClient() then
		if not script.Comm:FindFirstChild(name) then
			local remote = script.Comm:FindFirstChild("CreationRemote"):InvokeServer(name, "RemoteFunction")
			return remote;
		elseif script.Comm:FindFirstChild(name) and script.Comm:FindFirstChild(name):IsA("RemoteFunction") then
			return script.Comm:FindFirstChild(name)
		else
			return nil
		end
	elseif RunService:IsServer() then
		if not script:FindFirstChild("Comm") then
			local rems = Instance.new("Folder", script);
			rems.Name = "Comm";
		end

		if script.Comm:FindFirstChild(name) and not script.Comm:FindFirstChild(name):IsA("RemoteFunction") then
			warn("Remote Function name already exists as a RemoteEvent, try changing name before trying again.")
			return;
		elseif not script.Comm:FindFirstChild(name) then
			local remote = Instance.new("RemoteFunction", script.Comm)
			remote.Name = name
			return remote;
		elseif script.Comm:FindFirstChild(name) then
			return script.Comm:FindFirstChild(name)
		else
			return;
		end
	else
		return
	end
end

function createCreationRemote() : RemoteFunction?
	local rems;
	if not script:FindFirstChild("Comm") then
		rems = Instance.new("Folder", script);
		rems.Name = "Comm";
	else
		rems = script:FindFirstChild("Comm");
	end

	if not rems:FindFirstChild("CreationRemote") then
		local newRemote = Instance.new("RemoteFunction", rems);
		newRemote.Name = "CreationRemote";

		if newRemote and newRemote:IsA("RemoteFunction") then
			return newRemote;
		end
	elseif rems:FindFirstChild("CreationRemote") then
		local rems = script:FindFirstChild("Comm");
		local newRemote = rems:FindFirstChild("CreationRemote")

		if newRemote and newRemote:IsA("RemoteFunction") then
			return newRemote;
		end
	end

	return nil;
end

function Networking:InitNetworking()
	if RunService:IsClient() then
		return Promise.new(function(resolve, reject, onCancel)
			reject("This is a server only function.")
		end)
	end

	local creationRemote = createCreationRemote()

	if not creationRemote then
		return Promise.new(function(resolve, reject, onCancel)
			reject("Creation remote failed to be created.")
		end)
	end

	creationRemote.OnServerInvoke = function(player, remoteName, remoteType)
		if not Networking.RateLimits[player] then
			Networking.RateLimits[player] = 0
		end
		if Networking.RateLimits[player] >= Networking.RateLimit or Networking.MaxRemotes <= #script.Comm:GetChildren() then
			warn("Player "..player.Name.." has been rate limited, wait for the queue to clear.")
			return
		end

		Networking.RateLimits[player] += 1
		task.delay(1, function()
			Networking.RateLimits[player] -= 1
		end)

		if remoteType == "RemoteEvent" then
			return createEvent(remoteName)
		elseif remoteType == "RemoteFunction" then
			return createFunction(remoteName)
		end
	end
end

return Networking
