--// Requirements \\--
local Promise = require(game.ReplicatedStorage.Packages.Promise);
local RunService = game:GetService("RunService");

local viornix = {}
local s_version = "Alpha 0.0.6";
local CallbackEnabled_Client = false;
local CallbackEnabled_Server = false;
local ServicesInitialized_Client = false;
local ServicesInitialized_Server = false;
local UtilitiesAdded_Client = false;
local UtilitiesAdded_Server = false;
local Services = {
	Client = {};
	Server = {};
};
local Components = {
	Client = {};
	Server = {};
};
local Utilities = {
	Client = {},
	Server = {},
}
local InitializedServices = {
	Client = {};
	Server = {};
};
local BindEvents = {
	Client = {},
	Server = {},
};
local BindFuncs = {
	Client = {},
	Server = {},
};

function viornix:ListenInvoke(func: string, callback)
	if RunService:IsClient() then
		return Promise.new(function(resolve, reject, onCancel)
			if not script:FindFirstChild("RemoteFunctions") then
				local rems = Instance.new("Folder", script);
				rems.Name = "RemoteFunctions";
				if not rems:FindFirstChild(func) then
					warn("Remote Function does not exist.. creating one");
					local funcRemote = Instance.new("RemoteFunction", script.RemoteFunctions);
					funcRemote.Name = func;
					funcRemote.OnClientInvoke = function(...)
						return callback(...);
					end
				else
					local funcRemote = script.RemoteFunctions:FindFirstChild(func);
					funcRemote.OnClientInvoke = function(...)
						return callback(...);
					end
				end
			else
				if not script.RemoteFunctions:FindFirstChild(func) then
					warn("Remote Function does not exist.. creating one");
					local funcRemote = Instance.new("RemoteFunction", script.RemoteFunctions);
					funcRemote.Name = func;
					funcRemote.OnClientInvoke = function(...)
						return callback(...);
					end
				else
					local funcRemote = script.RemoteFunctions:FindFirstChild(func);
					funcRemote.OnClientInvoke = function(...)
						return callback(...);
					end
				end
			end
		end)
	elseif RunService:IsServer() then
		return Promise.new(function(resolve, reject, onCancel)
			if not script:FindFirstChild("RemoteFunctions") then
				local rems = Instance.new("Folder", script);
				rems.Name = "RemoteFunctions";
				if not rems:FindFirstChild(func) then
					warn("Remote Function does not exist.. creating one");
					local funcRemote = Instance.new("RemoteFunction", script.RemoteFunctions);
					funcRemote.Name = func;
					funcRemote.OnServerInvoke = function(...)
						return callback(...);
					end
				else
					local funcRemote = script.RemoteFunctions:FindFirstChild(func);
					funcRemote.OnServerInvoke = function(...)
						return callback(...);
					end
				end
			else
				if not script.RemoteFunctions:FindFirstChild(func) then
					warn("Remote Function does not exist.. creating one");
					local funcRemote = Instance.new("RemoteFunction", script.RemoteFunctions);
					funcRemote.Name = func;
					funcRemote.OnServerInvoke = function(...)
						return callback(...);
					end
				else
					local funcRemote = script.RemoteFunctions:FindFirstChild(func);
					funcRemote.OnServerInvoke = function(...)
						return callback(...);
					end
				end
			end
		end)
	end
end

function viornix:Invoke(...)
	local args = {...}
	local func, player

	if RunService:IsClient() then
		func = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("RemoteFunctions") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteFunctions";
			if not script.RemoteFunctions:FindFirstChild(func) then
				warn("Remote Function does not exist.. creating one");
				local rem = Instance.new("RemoteFunction", script.RemoteFunctions);
				rem.Name = func;
				return rem:InvokeServer({...});
			else
				local rem = script.RemoteFunctions:FindFirstChild(func);
				return rem:InvokeServer({...});
			end
		else
			if not script.RemoteFunctions:FindFirstChild(func) then
				warn("Remote Function does not exist.. creating one");
				local rem = Instance.new("RemoteFunction", script.RemoteFunctions);
				rem.Name = func;
				return rem:InvokeServer({...});
			else
				local rem = script.RemoteFunctions:FindFirstChild(func);
				return rem:InvokeServer({...});
			end
		end
	elseif RunService:IsServer() then
		if typeof(args[1]) == "Instance" and args[1]:IsA("Player") then
			player = table.remove(args, 1)
		end
		func = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("RemoteFunctions") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteFunctions";
			if not script.RemoteFunctions:FindFirstChild(func) then
				warn("Remote Function does not exist.. creating one");
				local rem = Instance.new("RemoteFunction", script.RemoteFunctions);
				rem.Name = func;
				return rem:InvokeClient(player, {...});
			else
				local rem = script.RemoteFunctions:FindFirstChild(func);
				return rem:InvokeClient(player, {...});
			end
		else
			if not script.RemoteFunctions:FindFirstChild(func) then
				warn("Remote Function does not exist.. creating one");
				local rem = Instance.new("RemoteFunction", script.RemoteFunctions);
				rem.Name = func;
				return rem:InvokeClient(player, {...});
			else
				local rem = script.RemoteFunctions:FindFirstChild(func);
				return rem:InvokeClient(player, {...});
			end
		end
	end
end

function viornix:ListenEvent(event, callback)
	if RunService:IsClient() then
		if not script:FindFirstChild("RemoteEvents") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteEvents";

			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev.OnClientEvent:Connect(function(...)
					return callback(...)
				end)
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev.OnClientEvent:Connect(function(...)
					return callback(...)
				end)
			end
		else
			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev.OnClientEvent:Connect(function(...)
					return callback(...)
				end)
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev.OnClientEvent:Connect(function(...)
					return callback(...)
				end)
			end
		end
	elseif RunService:IsServer() then
		if not script:FindFirstChild("RemoteEvents") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteEvents";

			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev.OnServerEvent:Connect(function(...)
					return callback(...)
				end)
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev.OnServerEvent:Connect(function(...)
					return callback(...)
				end)
			end
		else
			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev.OnServerEvent:Connect(function(...)
					return callback(...)
				end)
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev.OnServerEvent:Connect(function(...)
					return callback(...)
				end)
			end
		end
	end
end

function viornix:FireEvent(...)
	local args = {...}
	local event, player
	if RunService:IsClient() then
		event = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("RemoteEvents") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteEvents";

			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev:FireServer(unpack(args));
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev:FireServer(unpack(args));
			end
		else
			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev:FireServer(unpack(args));
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev:FireServer(unpack(args));
			end
		end
	elseif RunService:IsServer() then
		if typeof(args[1]) == "Instance" and args[1]:IsA("Player") then
			player = args[1]
			table.remove(args, 1)
		end
		event = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("RemoteEvents") then
			local rems = Instance.new("Folder", script);
			rems.Name = "RemoteEvents";

			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev:FireClient(player, unpack(args));
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev:FireClient(player, unpack(args));
			end
		else
			if not script:FindFirstChild("RemoteEvents"):FindFirstChild(event) then
				warn("Remote Event does not exist.. creating one");
				local ev = Instance.new("RemoteEvent", script.RemoteEvents);
				ev.Name = event;
				ev:FireClient(player, unpack(args));
			else
				local ev = script.RemoteEvents:FindFirstChild(event);
				ev:FireClient(player, unpack(args));
			end
		end
	end
end

function viornix:ListenBindableFunction(bindable, callback)
	if RunService:IsServer() then
		if not script:FindFirstChild("BindableFuncs_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Server";
			if not BindFuncs.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				BindFuncs.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);
				BindFuncs.Server[bindable].Name = bindable;
				BindFuncs.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				BindFuncs.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		else
			if not BindFuncs.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				BindFuncs.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);
				BindFuncs.Server[bindable].Name = bindable;
				BindFuncs.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				BindFuncs.Server[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		end
	elseif RunService:IsClient() then
		if not script:FindFirstChild("BindableFuncs_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Client";
			if not BindFuncs.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				BindFuncs.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);
				BindFuncs.Client[bindable].Name = bindable;
				BindFuncs.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				BindFuncs.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		else
			if not BindFuncs.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				BindFuncs.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);
				BindFuncs.Client[bindable].Name = bindable;
				BindFuncs.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			else
				BindFuncs.Client[bindable].OnInvoke = function(...)
					return callback(...)
				end
			end
		end
	end
end

function viornix:InvokeBindableFunction(...)
	local args = {...}
	local bindable
	if RunService:IsClient() then
		bindable = args[1];
		table.remove(args,  1);
		
		if not script:FindFirstChild("BindableFuncs_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Client";
			if not BindFuncs.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				BindFuncs.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);

				BindFuncs.Client[bindable]:Invoke(unpack(args));
			else
				BindFuncs.Client[bindable]:Invoke(unpack(args));
			end
		else
			if not BindFuncs.Client[bindable] then
				warn("Bindable Function does not exist on client.. creating one");
				BindFuncs.Client[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Client);

				BindFuncs.Client[bindable]:Invoke(unpack(args));
			else
				BindFuncs.Client[bindable]:Invoke(unpack(args));
			end
		end
	elseif RunService:IsServer() then
		bindable = args[1];
		table.remove(args,  1);

		if not script:FindFirstChild("BindableFuncs_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "BindableFuncs_Server";
			if not BindFuncs.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				BindFuncs.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);

				BindFuncs.Server[bindable]:Invoke(unpack(args));
			else
				BindFuncs.Server[bindable]:Invoke(unpack(args));
			end
		else
			if not BindFuncs.Server[bindable] then
				warn("Bindable Function does not exist on server.. creating one");
				BindFuncs.Server[bindable] = Instance.new("BindableFunction", script.BindableFuncs_Server);

				BindFuncs.Server[bindable]:Invoke(unpack(args));
			else
				BindFuncs.Server[bindable]:Invoke(unpack(args));
			end
		end
	end
end

function viornix:ListenBindableEvent(bindable, callback)
	if RunService:IsClient() then
		if not script:FindFirstChild("Bindables_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Client";

			if not BindEvents.Client[bindable] then
				warn("Bindable Event does not exist.. creating one");
				BindEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				BindEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				BindEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end	
		else
			if not BindEvents.Client[bindable] then
				warn("Bindable Event does not exist.. creating one");
				BindEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				BindEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				BindEvents.Client[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end
		end
	elseif RunService:IsServer() then
		if not script:FindFirstChild("Bindables_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Server";

			if not BindEvents.Server[bindable] then
				warn("Bindable Event does not exist.. creating one");
				BindEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				BindEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				BindEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end	
		else
			if not BindEvents.Server[bindable] then
				warn("Bindable Event does not exist.. creating one");
				BindEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				BindEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			else
				BindEvents.Server[bindable].Event:Connect(function(...)
					return callback(...)
				end)
			end
		end
	end
end

function viornix:FireBindableEvent(...)
	local args = {...}
	local bindable
	if RunService:IsClient() then
		bindable = args[1];
		table.remove(args, 1)
		if not script:FindFirstChild("Bindables_Client") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Client";
			if not BindEvents.Client[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				BindEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				BindEvents.Client[bindable]:Fire(unpack(args));
			else
				BindEvents.Client[bindable]:Fire(unpack(args));
			end
		else
			if not BindEvents.Client[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				BindEvents.Client[bindable] = Instance.new("BindableEvent", script.Bindables_Client);

				BindEvents.Client[bindable]:Fire(unpack(args));
			else
				BindEvents.Client[bindable]:Fire(unpack(args));
			end
		end
	elseif RunService:IsServer() then
		bindable = args[1];
		table.remove(args, 1)
		if not script:FindFirstChild("Bindables_Server") then
			local binds = Instance.new("Folder", script);
			binds.Name = "Bindables_Server";
			if not BindEvents.Server[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				BindEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				BindEvents.Server[bindable]:Fire(unpack(args));
			else
				BindEvents.Server[bindable]:Fire(unpack(args));
			end
		else
			if not BindEvents.Server[bindable] then
				warn("Bindable Event does not exist on client.. creating one");
				BindEvents.Server[bindable] = Instance.new("BindableEvent", script.Bindables_Server);

				BindEvents.Server[bindable]:Fire(unpack(args));
			else
				BindEvents.Server[bindable]:Fire(unpack(args));
			end
		end
	end
end

function viornix:GetService(service: string)
	if RunService:IsServer() then
		if InitializedServices.Server[service] then
			return InitializedServices.Server[service]
		end
		error("Could not find service '" .. service .. "'! Make sure the service name is correct before trying again.")
	elseif RunService:IsClient() then
		if InitializedServices.Client[service] then
			return InitializedServices.Client[service]
		end
		error("Could not find service '" .. service .. "'! Make sure the service name is correct before trying again.")
	end
end

--// Only for components as services have it already included

function viornix:GetUtility(util: string)
	if RunService:IsServer() then
		if Utilities.Server[util] then
			return Utilities.Server[util]
		else
			Promise.reject("Utility does not exist!")
		end
	elseif RunService:IsClient() then
		if Utilities.Client[util] then
			return Utilities.Client[util]
		else
			Promise.reject("Utility does not exist!")
		end
	end
end

function viornix:AddUtilities(path: Folder)
	if RunService:IsServer() then
		return Promise.new(function(resolve, reject)
			if UtilitiesAdded_Server then
				reject("Utilities already added on server!");
			end

			for _, v in path:GetChildren() do
				if v:IsA("ModuleScript") and not Utilities.Server[v] then
					Utilities.Server[v.Name] = require(v);
				else
					reject("Utility already added or item is not a ModuleScript!");
				end
			end
			UtilitiesAdded_Server = true
			resolve()
		end)
	elseif RunService:IsClient() then
		return Promise.new(function(resolve, reject)
			if UtilitiesAdded_Client then
				reject("Utilities already added on client!");
			end

			for _, v in path:GetChildren() do
				if v:IsA("ModuleScript") and not Utilities.Client[v] then
					Utilities.Client[v.Name] = require(v);
				else
					reject("Utility already added or item is not a ModuleScript!");
				end
			end
			UtilitiesAdded_Client = true
			resolve()
		end)
	end
end

function viornix:AddComponents(path: Folder)
	if RunService:IsServer() then
		return Promise.new(function(resolve, reject)
			for i,v in path:GetChildren() do
				if v:IsA("ModuleScript") and not Components.Server[v] then
					local x = require(v);
					Components.Server[v] = true;
				else
					reject("Failed to add components. Possible issues are not a module or function already called on the server.")
				end
			end
			resolve("Viornix version: " .. s_version .. " has successfully added components at path:", path)
		end)
	elseif RunService:IsClient() then
		return Promise.new(function(resolve, reject)
			for i,v in path:GetChildren() do
				if v:IsA("ModuleScript") and not Components.Client[v] then
					local x = require(v);
					Components.Client[v] = true;
				else
					reject("Failed to add components. Possible issues are not a module or function already called on the client.")
				end
			end
			resolve("Viornix version: " .. s_version .. " has successfully added components at path:", path)
		end)
	end
end

function viornix:AddServices(path: Folder, callback: boolean)
	if RunService:IsClient() then
		if callback then
			CallbackEnabled_Client = true;
		else
			CallbackEnabled_Client = false;
		end
		if not path then return end
		for i,v in path:GetChildren() do
			if v:IsA("ModuleScript") then
				require(v);
			end
		end
	elseif RunService:IsServer() then
		if callback then
			CallbackEnabled_Server = true;
		else
			CallbackEnabled_Server = false;
		end
		if not path then return end
		for i,v in path:GetChildren() do
			if v:IsA("ModuleScript") then
				require(v);
			end
		end
	end
end

function viornix:InitializeServices()
	if RunService:IsClient() then
		return Promise.new(function(resolve, reject)
			for i,v in Services.Client do
				if v.Initialized == true then
					reject(i .. " has already been intitialized.");
				end

				if v.service ~= nil then
					InitializedServices.Client[i] = v.service;
					if v.service["Init"] then
						v.service:Init();
					else
						reject("CRITICAL ERROR:" .. i .." does not have an Init() function.")
					end
				else
					reject(i, " returned nil during initialization.")
				end
			end

			print("Successfully Initialized All Services.")

			for i,v in InitializedServices.Client do
				if CallbackEnabled_Client then
					if v["StartCallback"] ~= nil then
						v:StartCallback();
					else
						reject("CRITICAL ERROR: Start callback does not exist, try adding {} to the CreateService function parameters.");
					end
				end
				if v["Start"] ~= nil then
					v:Start();
				else
					reject("CRITICAL ERROR:" .. i .." does not have an Start() function.")
				end
			end

			print("Successfully Started All Services.");
			resolve()
		end)
	elseif RunService:IsServer() then
		return Promise.new(function(resolve, reject)
			for i,v in Services.Server do
				if v.Initialized == true then
					reject(i .. " has already been intitialized.");
				end

				if v.service ~= nil then
					InitializedServices.Server[i] = v.service;
					if v.service["Init"] then
						v.service:Init();
					else
						reject("CRITICAL ERROR:" .. i .." does not have an Init() function.")
					end
				else
					reject(i, " returned nil during initialization.")
				end
			end

			print("Successfully Initialized All Services.")

			for i,v in InitializedServices.Server do
				if CallbackEnabled_Server then
					if v["StartCallback"] ~= nil then
						v:StartCallback();
					else
						reject("CRITICAL ERROR: Start callback does not exist, try adding {} to the CreateService function parameters.");
					end
				end
				if v["Start"] ~= nil then
					v:Start();
				else
					reject("CRITICAL ERROR:" .. i .." does not have an Start() function.")
				end
			end

			print("Successfully Started All Services.");
			resolve()
		end)
	end
end

function viornix:CreateService(serviceName: string, extraParams: table)
	if RunService:IsClient() then
		local Service = {}
		Service.__index = Service

		local Self = setmetatable({}, Service);

		if CallbackEnabled_Client then
			function Service:StartCallback()
				if extraParams.Services ~= nil then
					local serviceTable = {};
					for i,v in extraParams.Services do
						serviceTable[v] = viornix:GetService(v);
					end
					Service.Services = serviceTable;
					print("Set services in", serviceName, Service.Services);
				end
				if extraParams.Utilities ~= nil then
					local utilityTable = {};
					for i,v in extraParams.Utilities do
						utilityTable[v] = viornix:GetUtility(v);
					end
					Service.Utilities = utilityTable;
					print("Set utilities in", serviceName, Service.Utilities);
				end
			end
		end

		Service.ServiceName = serviceName;

		Services.Client[serviceName] = {
			initialized = false;
			service = Service;
		};

		print(serviceName, "Intialized", Services.Client[serviceName])
		return Service;
	elseif RunService:IsServer() then
		local Service = {}
		Service.__index = Service

		local Self = setmetatable({}, Service);

		if CallbackEnabled_Server then
			function Service:StartCallback()
				if extraParams.Services ~= nil then
					local serviceTable = {};
					for i,v in extraParams.Services do
						serviceTable[v] = viornix:GetService(v);
					end
					Service.Services = serviceTable;
					print("Set services in", serviceName, Service.Services);
				end
				if extraParams.Utilities ~= nil then
					local utilityTable = {};
					for i,v in extraParams.Utilities do
						utilityTable[v] = viornix:GetUtility(v);
					end
					Service.Utilities = utilityTable;
					print("Set utilities in", serviceName, Service.Utilities);
				end
			end
		end

		Service.ServiceName = serviceName;

		Services.Server[serviceName] = {
			initialized = false;
			service = Service;
		};

		print(serviceName, "Intialized", Services.Server[serviceName])
		return Service;
	end
end

return viornix
