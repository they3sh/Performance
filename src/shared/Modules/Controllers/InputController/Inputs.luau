
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));

-- Constants
local AttackEvent = Remote.New("CombatAttack");
local AbilityEvent = Remote.New("CombatAbility");

return {

    KeyCode = {
        ["Q"] = {
            fn = function(actionName: string, inputState: Enum.UserInputState, inputObject)
                AbilityEvent:FindFirstChild("ability1");
            end
        },
        ["E"] = {
            fn = function(actionName: string, inputState: Enum.UserInputState, inputObject)
                AbilityEvent:FindFirstChild("ability3");
            end
        },
        ["LeftShift"] = {
            fn = function(actionName: string, inputState: Enum.UserInputState, inputObject)
                AbilityEvent:FindFirstChild("ability2");
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