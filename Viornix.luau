--// Requirements \\--

local Promise = require(game.ReplicatedStorage.Packages.Promise);
local RunService = game:GetService("RunService");

local viornix = {}
local s_version = "Alpha 1.1.3";
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

function viornix:SetupNetworking(packages: Folder)
	if RunService:IsServer() then
		self.Networking = require(packages.Networking);
		self.Networking:InitNetworking();
	elseif RunService:IsClient() then
		self.Networking = require(packages.Networking);
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
					--print("Set services in", serviceName, Service.Services);
				end
				if extraParams.Utilities ~= nil then
					local utilityTable = {};
					for i,v in extraParams.Utilities do
						utilityTable[v] = viornix:GetUtility(v);
					end
					Service.Utilities = utilityTable;
					--print("Set utilities in", serviceName, Service.Utilities);
				end
			end
		end

		Service.ServiceName = serviceName;

		Services.Client[serviceName] = {
			initialized = false;
			service = Service;
		};

		--print(serviceName, "Intialized", Services.Client[serviceName])
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
					--print("Set services in", serviceName, Service.Services);
				end
				if extraParams.Utilities ~= nil then
					local utilityTable = {};
					for i,v in extraParams.Utilities do
						utilityTable[v] = viornix:GetUtility(v);
					end
					Service.Utilities = utilityTable;
					--print("Set utilities in", serviceName, Service.Utilities);
				end
			end
		end

		Service.ServiceName = serviceName;

		Services.Server[serviceName] = {
			initialized = false;
			service = Service;
		};

		--print(serviceName, "Intialized", Services.Server[serviceName])
		return Service;
	end
end

return viornix
