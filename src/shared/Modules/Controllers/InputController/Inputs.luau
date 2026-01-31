
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));

-- Constants
local AttackEvent = Remote.New("AttackEvent");
local BlockEvent = Remote.New("BlockEvent");

return {





    KeyCode = {
        ["F"] = {
            fn = function(actionName: string, inputState: Enum.UserInputState, inputObject)
                BlockEvent:FireServer();
            end,
        }
    },

    UserInputType = {
        ["MouseButton1"] = {
            fn = function(actionName: string, inputState: Enum.UserInputState, inputObject)
                if inputState == Enum.UserInputState.Begin then return end

                AttackEvent:FireServer();

            end,
        }
    }

}