-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Vars
local Viewport = workspace.CurrentCamera.ViewportSize
local Library = {}
local DefaultTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function Library:validate(defaults, options)
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function Library:tween(object, goal, callback)
	local tween = TweenService:Create(object, DefaultTweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:new(options)
	options = Library:validate({
		name = "UI Library Test"
	}, options or {})

	local GUI = {
		CurrentTab = nil
	}

	-- Main Window Frame
	do
		GUI["1"] = Instance.new(
			"ScreenGui",
			RunService:IsStudio()
				and Players.LocalPlayer:WaitForChild("PlayerGui")
				or CoreGui
		)
		GUI["1"].Name = "MyLibrary"
		GUI["1"].IgnoreGuiInset = true
		GUI["1"].ResetOnSpawn = false

		GUI["2"] = Instance.new("Frame", GUI["1"])
		GUI["2"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
		GUI["2"].BorderSizePixel = 0
		GUI["2"].AnchorPoint = Vector2.new(0.5, 0.5)
		GUI["2"].Size = UDim2.new(0, 400, 0, 300)
		GUI["2"].Position = UDim2.fromScale(0.5, 0.5)
		GUI["2"].Name = "Main"

		GUI["3"] = Instance.new("UICorner", GUI["2"])
		GUI["3"].CornerRadius = UDim.new(0, 6)
	end

	-- Topbar
	do
		GUI["4"] = Instance.new("Frame", GUI["2"])
		GUI["4"].BorderSizePixel = 0
		GUI["4"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
		GUI["4"].Size = UDim2.new(1, 0, 0, 30)
		GUI["4"].Name = "Topbar"

		GUI["5"] = Instance.new("UICorner", GUI["4"])
		GUI["5"].CornerRadius = UDim.new(0, 6)

		GUI["6"] = Instance.new("Frame", GUI["4"])
		GUI["6"].BorderSizePixel = 0
		GUI["6"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
		GUI["6"].AnchorPoint = Vector2.new(0, 1)
		GUI["6"].Size = UDim2.new(1, 0, 0.5, 0)
		GUI["6"].Position = UDim2.new(0, 0, 1, 0)
		GUI["6"].Name = "Extension"

		GUI["7"] = Instance.new("TextLabel", GUI["4"])
		GUI["7"].BorderSizePixel = 0
		GUI["7"].TextSize = 14
		GUI["7"].TextXAlignment = Enum.TextXAlignment.Left
		GUI["7"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		GUI["7"].FontFace = Font.new(
			"rbxasset://fonts/families/GothamSSm.json",
			Enum.FontWeight.Regular,
			Enum.FontStyle.Normal
		)
		GUI["7"].TextColor3 = Color3.fromRGB(255, 255, 255)
		GUI["7"].BackgroundTransparency = 1
		GUI["7"].Size = UDim2.new(0.5, 0, 1, 0)
		GUI["7"].Text = options.name
		GUI["7"].Name = "Title"

		GUI["8"] = Instance.new("UIPadding", GUI["7"])
		GUI["8"].PaddingLeft = UDim.new(0, 8)

		GUI["9"] = Instance.new("ImageButton", GUI["4"])
		GUI["9"].BorderSizePixel = 0
		GUI["9"].BackgroundTransparency = 1
		GUI["9"].AnchorPoint = Vector2.new(1, 0.5)
		GUI["9"].Image = "rbxassetid://137166058322874"
		GUI["9"].Size = UDim2.new(0, 24, 0, 24)
		GUI["9"].Position = UDim2.new(1, -4, 0.5, 0)
		GUI["9"].Name = "Minimize"

		GUI["a"] = Instance.new("Frame", GUI["4"])
		GUI["a"].BorderSizePixel = 0
		GUI["a"].BackgroundColor3 = Color3.fromRGB(71, 71, 71)
		GUI["a"].AnchorPoint = Vector2.new(0, 1)
		GUI["a"].Size = UDim2.new(1, 0, 0, 1)
		GUI["a"].Position = UDim2.new(0, 0, 1, 0)
		GUI["a"].Name = "Line"

		GUI["b"] = Instance.new("UICorner", GUI["a"])
		GUI["b"].CornerRadius = UDim.new(0, 6)
	end

	-- Navigation
	do
		GUI["c"] = Instance.new("Frame", GUI["2"])
		GUI["c"].BorderSizePixel = 0
		GUI["c"].BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		GUI["c"].Size = UDim2.new(0, 120, 1, -31)
		GUI["c"].Position = UDim2.new(0, 0, 0, 30)
		GUI["c"].Name = "Navigation"

		GUI["d"] = Instance.new("UICorner", GUI["c"])
		GUI["d"].CornerRadius = UDim.new(0, 6)

		GUI["10"] = Instance.new("Frame", GUI["c"])
		GUI["10"].BorderSizePixel = 0
		GUI["10"].BackgroundTransparency = 1
		GUI["10"].Size = UDim2.new(1, 0, 1, 0)
		GUI["10"].Name = "ButtonHolder"

		GUI["11"] = Instance.new("UIPadding", GUI["10"])
		GUI["11"].PaddingTop = UDim.new(0, 8)
		GUI["11"].PaddingBottom = UDim.new(0, 8)

		GUI["12"] = Instance.new("UIListLayout", GUI["10"])
		GUI["12"].Padding = UDim.new(0, 1)
		GUI["12"].SortOrder = Enum.SortOrder.LayoutOrder

		GUI["19"] = Instance.new("Frame", GUI["c"])
		GUI["19"].BorderSizePixel = 0
		GUI["19"].BackgroundColor3 = Color3.fromRGB(71, 71, 71)
		GUI["19"].Size = UDim2.new(0, 1, 1, 0)
		GUI["19"].Position = UDim2.new(1, 0, 0, 0)
		GUI["19"].Name = "Line"
	end

	-- Tabs Creator
	function GUI:CreateTab(options)
		options = Library:validate({
			name = "Preview",
			icon = "rbxassetid://103051585601742"
		}, options or {})

		local Tab = {
			Hover = false,
			Active = false
		}

		Tab["16"] = Instance.new("TextButton", GUI["10"])
		Tab["16"].BorderSizePixel = 0
		Tab["16"].TextSize = 12
		Tab["16"].TextXAlignment = Enum.TextXAlignment.Left
		Tab["16"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab["16"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Tab["16"].TextColor3 = Color3.fromRGB(145, 145, 145)
		Tab["16"].BackgroundTransparency = 1
		Tab["16"].Size = UDim2.new(1, 0, 0, 24)
		Tab["16"].Text = options.name
		Tab["16"].Name = "Inactive"

		Tab["17"] = Instance.new("UIPadding", Tab["16"])
		Tab["17"].PaddingLeft = UDim.new(0, 28)

		Tab["18"] = Instance.new("ImageLabel", Tab["16"])
		Tab["18"].BorderSizePixel = 0
		Tab["18"].ImageColor3 = Color3.fromRGB(76, 76, 76)
		Tab["18"].Image = options.icon
		Tab["18"].Size = UDim2.new(0, 20, 0, 20)
		Tab["18"].BackgroundTransparency = 1
		Tab["18"].Position = UDim2.new(0, -24, 0.5, -10)

		Tab["1a"] = Instance.new("Frame", GUI["2"])
		Tab["1a"].BorderSizePixel = 0
		Tab["1a"].BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Tab["1a"].AnchorPoint = Vector2.new(1, 0)
		Tab["1a"].Size = UDim2.new(1, -133, 1, -42)
		Tab["1a"].Position = UDim2.new(1, -6, 0, 36)
		Tab["1a"].Name = "ContentContainer"
		Tab["1a"].BackgroundTransparency = 1
		Tab["1a"].Visible = false

		Tab["1b"] = Instance.new("ScrollingFrame", Tab["1a"])
		Tab["1b"].BorderSizePixel = 0
		Tab["1b"].Name = "HomeTab"
		Tab["1b"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab["1b"].Selectable = false
		Tab["1b"].Size = UDim2.new(1, 0, 1, 0)
		Tab["1b"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab["1b"].ScrollBarThickness = 0
		Tab["1b"].BackgroundTransparency = 1
		Tab["1b"].Visible = false
		Tab["1b"].AutomaticCanvasSize = Enum.AutomaticSize.Y

		Tab["20"] = Instance.new("UIListLayout", Tab["1b"])
		Tab["20"].Padding = UDim.new(0, 4)
		Tab["20"].SortOrder = Enum.SortOrder.LayoutOrder

		Tab["21"] = Instance.new("UIPadding", Tab["1b"])
		Tab["21"].PaddingTop = UDim.new(0, 4)
		Tab["21"].PaddingBottom = UDim.new(0, 4)
		Tab["21"].PaddingLeft = UDim.new(0, 4)
		Tab["21"].PaddingRight = UDim.new(0, 4)

		-- Tab Activation Methods
		function Tab:Deactivate()
			Tab.Active = false
			Tab["1a"].Visible = false
			Library:tween(Tab["16"], {TextColor3 = Color3.fromRGB(144, 144, 144)})
			Library:tween(Tab["18"], {ImageColor3 = Color3.fromRGB(144, 144, 144)})
			Library:tween(Tab["16"], {BackgroundTransparency = 1})
			Tab["1b"].Visible = false
		end

		function Tab:Activate()
			if GUI.CurrentTab then
				GUI.CurrentTab:Deactivate()
			end
			Tab.Active = true
			Tab["1a"].Visible = true
			Tab["1b"].Visible = true
			Library:tween(Tab["16"], {BackgroundTransparency = 0.8})
			Library:tween(Tab["16"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
			Library:tween(Tab["18"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
			GUI.CurrentTab = Tab
		end

		Tab["16"].MouseButton1Click:Connect(function()
			Tab:Activate()
		end)

		if not GUI.CurrentTab then
			Tab:Activate()
		end

		-- Element: Button
		function Tab:Button(options)
			options = Library:validate({
				name = "Preview",
				callback = function() end
			}, options or {})

			local Button = {
				Hover = false,
				MouseDown = false
			}

			do
				Button["1c"] = Instance.new("Frame", Tab["1b"])
				Button["1c"].BorderSizePixel = 0
				Button["1c"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
				Button["1c"].Size = UDim2.new(1, 0, 0, 32)
				Button["1c"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button["1c"].Name = "Button"

				Button["1d"] = Instance.new("UICorner", Button["1c"])
				Button["1d"].CornerRadius = UDim.new(0, 4)

				Button["1e"] = Instance.new("UIStroke", Button["1c"])
				Button["1e"].Thickness = 0.5
				Button["1e"].Color = Color3.fromRGB(71, 71, 71)
				Button["1e"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				Button["1f"] = Instance.new("TextLabel", Button["1c"])
				Button["1f"].BorderSizePixel = 0
				Button["1f"].TextSize = 14
				Button["1f"].TextXAlignment = Enum.TextXAlignment.Left
				Button["1f"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button["1f"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Button["1f"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Button["1f"].BackgroundTransparency = 1
				Button["1f"].Size = UDim2.new(1, -20, 1, 0)
				Button["1f"].Position = UDim2.new(0, 10, 0, 0)
				Button["1f"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button["1f"].Text = options.name
				Button["1f"].Name = "Title"
			end

			function Button:SetText(text)
				Button["1f"].Text = text
			end

			function Button:SetCallBack(fn)
				options.callback = fn
			end
			Button.SetCallback = Button.SetCallBack

			do
				Button["1c"].MouseEnter:Connect(function()
					Button.Hover = true
					Library:tween(Button["1e"], {Color = Color3.fromRGB(120, 120, 120)})
				end)

				Button["1c"].MouseLeave:Connect(function()
					Button.Hover = false
					if not Button.MouseDown then
						Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(32, 32, 32)})
						Library:tween(Button["1e"], {Color = Color3.fromRGB(71, 71, 71)})
					end
				end)

				UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
						Button.MouseDown = true
						Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(20, 20, 20)})
					end
				end)

				UserInputService.InputEnded:Connect(function(input, gpe)
					if gpe then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Button.MouseDown and Button.Hover then
							options.callback()
						end

						Button.MouseDown = false

						if Button.Hover then
							Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(38, 38, 38)})
							Library:tween(Button["1e"], {Color = Color3.fromRGB(120, 120, 120)})
						else
							Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(32, 32, 32)})
							Library:tween(Button["1e"], {Color = Color3.fromRGB(71, 71, 71)})
						end
					end
				end)
			end

			return Button
		end

		-- Element: Label
		function Tab:Label(options)
			options = Library:validate({
				name = "Label"
			}, options or {})

			local Label = {}

			do
				Label["1"] = Instance.new("Frame", Tab["1b"])
				Label["1"].BorderSizePixel = 0
				Label["1"].BackgroundColor3 = Color3.fromRGB(71, 60, 4)
				Label["1"].Size = UDim2.new(1, 0, 0, 26)
				Label["1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label["1"].Name = "Label"

				Label["2"] = Instance.new("UICorner", Label["1"])
				Label["2"].CornerRadius = UDim.new(0, 4)

				Label["3"] = Instance.new("UIStroke", Label["1"])
				Label["3"].Thickness = 0.5
				Label["3"].Color = Color3.fromRGB(230, 204, 11)
				Label["3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				Label["4"] = Instance.new("TextLabel", Label["1"])
				Label["4"].BorderSizePixel = 0
				Label["4"].TextSize = 14
				Label["4"].TextXAlignment = Enum.TextXAlignment.Left
				Label["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Label["4"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Label["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Label["4"].BackgroundTransparency = 1
				Label["4"].Size = UDim2.new(1, -20, 1, 0)
				Label["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label["4"].Text = options.name
				Label["4"].Name = "Title"

				Label["5"] = Instance.new("UIPadding", Label["1"])
				Label["5"].PaddingTop = UDim.new(0, 6)
				Label["5"].PaddingRight = UDim.new(0, 6)
				Label["5"].PaddingLeft = UDim.new(0, 6)
				Label["5"].PaddingBottom = UDim.new(0, 6)
			end

			function Label:SetText(text)
				Label["4"].Text = text
			end

			return Label
		end

		-- Element: Slider
		function Tab:Slider(options)
			options = Library:validate({
				name = "Slider",
				min = 0,
				max = 100,
				default = 50,
				callback = function(value) end
			}, options or {})

			local Slider = {
				Value = math.clamp(options.default, options.min, options.max),
				Dragging = false
			}

			do
				Slider["1"] = Instance.new("Frame", Tab["1b"])
				Slider["1"].BorderSizePixel = 0
				Slider["1"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
				Slider["1"].Size = UDim2.new(1, 0, 0, 38)
				Slider["1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider["1"].Name = "Slider"

				Slider["2"] = Instance.new("UICorner", Slider["1"])
				Slider["2"].CornerRadius = UDim.new(0, 4)

				Slider["3"] = Instance.new("UIStroke", Slider["1"])
				Slider["3"].Thickness = 0.5
				Slider["3"].Color = Color3.fromRGB(71, 71, 71)
				Slider["3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				Slider["4"] = Instance.new("TextLabel", Slider["1"])
				Slider["4"].BorderSizePixel = 0
				Slider["4"].TextSize = 14
				Slider["4"].TextXAlignment = Enum.TextXAlignment.Left
				Slider["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider["4"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Slider["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Slider["4"].BackgroundTransparency = 1
				Slider["4"].Size = UDim2.new(1, -24, 1, -10)
				Slider["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider["4"].Text = options.name
				Slider["4"].Name = "Title"

				Slider["5"] = Instance.new("UIPadding", Slider["1"])
				Slider["5"].PaddingTop = UDim.new(0, 6)
				Slider["5"].PaddingRight = UDim.new(0, 6)
				Slider["5"].PaddingLeft = UDim.new(0, 6)
				Slider["5"].PaddingBottom = UDim.new(0, 6)

				Slider["6"] = Instance.new("TextLabel", Slider["1"])
				Slider["6"].BorderSizePixel = 0
				Slider["6"].TextSize = 14
				Slider["6"].TextXAlignment = Enum.TextXAlignment.Right
				Slider["6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider["6"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Slider["6"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Slider["6"].BackgroundTransparency = 1
				Slider["6"].AnchorPoint = Vector2.new(1, 0)
				Slider["6"].Size = UDim2.new(0, 32, 1, -10)
				Slider["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider["6"].Text = tostring(Slider.Value)
				Slider["6"].Name = "Value"
				Slider["6"].Position = UDim2.new(1, 0, 0, 0)

				Slider["7"] = Instance.new("Frame", Slider["1"])
				Slider["7"].BorderSizePixel = 0
				Slider["7"].BackgroundColor3 = Color3.fromRGB(12, 12, 12)
				Slider["7"].AnchorPoint = Vector2.new(0, 1)
				Slider["7"].Size = UDim2.new(1, 0, 0, 4)
				Slider["7"].Position = UDim2.new(0, 0, 1, 0)
				Slider["7"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider["7"].Name = "SliderBack"

				Slider["8"] = Instance.new("UICorner", Slider["7"])

				Slider["9"] = Instance.new("UIStroke", Slider["7"])
				Slider["9"].Color = Color3.fromRGB(64, 64, 64)

				local startFraction = (Slider.Value - options.min) / (options.max - options.min)
				Slider["a"] = Instance.new("Frame", Slider["7"])
				Slider["a"].BorderSizePixel = 0
				Slider["a"].BackgroundColor3 = Color3.fromRGB(107, 170, 218)
				Slider["a"].Size = UDim2.new(startFraction, 0, 1, 0)
				Slider["a"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider["a"].Name = "Draggable"
			end

			function Slider:Set(value)
				value = math.clamp(math.floor(value + 0.5), options.min, options.max)
				Slider.Value = value
				local fraction = (value - options.min) / (options.max - options.min)
				Slider["a"].Size = UDim2.new(fraction, 0, 1, 0)
				Slider["6"].Text = tostring(value)
				options.callback(value)
			end

			function Slider:SetCallback(fn)
				options.callback = fn
			end

			do
				local function updateFromX(x)
					local absPos = Slider["7"].AbsolutePosition.X
					local absSize = Slider["7"].AbsoluteSize.X
					local fraction = math.clamp((x - absPos) / absSize, 0, 1)
					Slider:Set(options.min + fraction * (options.max - options.min))
				end

				Slider["7"].InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch then
						Slider.Dragging = true
						updateFromX(input.Position.X)
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if Slider.Dragging
						and (input.UserInputType == Enum.UserInputType.MouseMovement
							or input.UserInputType == Enum.UserInputType.Touch) then
						updateFromX(input.Position.X)
					end
				end)

				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch then
						Slider.Dragging = false
					end
				end)
			end

			return Slider
		end

		-- Element: Dropdown
		function Tab:Dropdown(options)
			options = Library:validate({
				name = "Dropdown",
				options = {},
				default = nil,
				callback = function(value) end
			}, options or {})

			local Dropdown = {
				Open = false,
				Selected = options.default,
				OptionButtons = {}
			}

			local collapsedHeight = 30
			local rowHeight = 22

			do
				Dropdown["1"] = Instance.new("TextButton", Tab["1b"])
				Dropdown["1"].BorderSizePixel = 0
				Dropdown["1"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
				Dropdown["1"].ClipsDescendants = true
				Dropdown["1"].Size = UDim2.new(1, 0, 0, collapsedHeight)
				Dropdown["1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown["1"].Name = "Dropdown"
				Dropdown["1"].Text = ""
				Dropdown["1"].AutoButtonColor = false

				Dropdown["2"] = Instance.new("UICorner", Dropdown["1"])
				Dropdown["2"].CornerRadius = UDim.new(0, 4)

				Dropdown["3"] = Instance.new("UIStroke", Dropdown["1"])
				Dropdown["3"].Thickness = 0.5
				Dropdown["3"].Color = Color3.fromRGB(71, 71, 71)
				Dropdown["3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				Dropdown["4"] = Instance.new("TextLabel", Dropdown["1"])
				Dropdown["4"].BorderSizePixel = 0
				Dropdown["4"].TextSize = 14
				Dropdown["4"].TextXAlignment = Enum.TextXAlignment.Left
				Dropdown["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown["4"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Dropdown["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown["4"].BackgroundTransparency = 1
				Dropdown["4"].Size = UDim2.new(1, -20, 0, 20)
				Dropdown["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown["4"].Text = options.default and (options.name .. ": " .. tostring(options.default)) or options.name
				Dropdown["4"].Name = "Title"

				Dropdown["5"] = Instance.new("UIPadding", Dropdown["1"])
				Dropdown["5"].PaddingTop = UDim.new(0, 6)
				Dropdown["5"].PaddingRight = UDim.new(0, 6)
				Dropdown["5"].PaddingLeft = UDim.new(0, 6)
				Dropdown["5"].PaddingBottom = UDim.new(0, 6)

				Dropdown["6"] = Instance.new("ImageLabel", Dropdown["1"])
				Dropdown["6"].BorderSizePixel = 0
				Dropdown["6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown["6"].AnchorPoint = Vector2.new(1, 0)
				Dropdown["6"].Image = "rbxassetid://76880195348310"
				Dropdown["6"].Size = UDim2.new(0, 20, 0, 20)
				Dropdown["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown["6"].BackgroundTransparency = 1
				Dropdown["6"].Name = "Icon"
				Dropdown["6"].Position = UDim2.new(1, 0, 0, 0)

				Dropdown["7"] = Instance.new("Frame", Dropdown["1"])
				Dropdown["7"].BorderSizePixel = 0
				Dropdown["7"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown["7"].Size = UDim2.new(1, 0, 1, -24)
				Dropdown["7"].Position = UDim2.new(0, 0, 0, 26)
				Dropdown["7"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown["7"].Name = "OptionHolder"
				Dropdown["7"].BackgroundTransparency = 1

				Dropdown["8"] = Instance.new("UIListLayout", Dropdown["7"])
				Dropdown["8"].Padding = UDim.new(0, 4)
				Dropdown["8"].SortOrder = Enum.SortOrder.LayoutOrder

				for _, optionName in ipairs(options.options) do
					local isSelected = (optionName == Dropdown.Selected)

					local optionButton = Instance.new("TextButton", Dropdown["7"])
					optionButton.BorderSizePixel = 0
					optionButton.TextSize = 14
					optionButton.BackgroundColor3 = isSelected and Color3.fromRGB(86, 86, 86) or Color3.fromRGB(51, 51, 51)
					optionButton.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
					optionButton.TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(207, 207, 207)
					optionButton.Size = UDim2.new(1, 0, 0, 18)
					optionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					optionButton.Text = optionName
					optionButton.Name = "Option"
					optionButton.AutoButtonColor = false

					local optionCorner = Instance.new("UICorner", optionButton)
					optionCorner.CornerRadius = UDim.new(0, 2)

					local optionStroke = Instance.new("UIStroke", optionButton)
					optionStroke.Color = isSelected and Color3.fromRGB(163, 163, 163) or Color3.fromRGB(71, 71, 71)
					optionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

					Dropdown.OptionButtons[optionName] = {
						Button = optionButton,
						Stroke = optionStroke
					}

					optionButton.MouseEnter:Connect(function()
						if optionName ~= Dropdown.Selected then
							Library:tween(optionButton, {BackgroundColor3 = Color3.fromRGB(51, 51, 51)})
							Library:tween(optionStroke, {Color = Color3.fromRGB(255, 255, 255)})
						end
					end)

					optionButton.MouseLeave:Connect(function()
						if optionName ~= Dropdown.Selected then
							Library:tween(optionStroke, {Color = Color3.fromRGB(71, 71, 71)})
						end
					end)

					optionButton.MouseButton1Click:Connect(function()
						Dropdown:Select(optionName)
					end)
				end
			end

			function Dropdown:Select(optionName)
				local previous = Dropdown.Selected
				if previous and Dropdown.OptionButtons[previous] then
					local prev = Dropdown.OptionButtons[previous]
					Library:tween(prev.Button, {BackgroundColor3 = Color3.fromRGB(51, 51, 51)})
					Library:tween(prev.Stroke, {Color = Color3.fromRGB(71, 71, 71)})
				end

				Dropdown.Selected = optionName
				local current = Dropdown.OptionButtons[optionName]
				if current then
					Library:tween(current.Button, {BackgroundColor3 = Color3.fromRGB(86, 86, 86)})
					Library:tween(current.Stroke, {Color = Color3.fromRGB(163, 163, 163)})
				end

				Dropdown["4"].Text = options.name .. ": " .. tostring(optionName)
				options.callback(optionName)
			end

			function Dropdown:SetCallback(fn)
				options.callback = fn
			end

			do
				local expandedHeight = collapsedHeight + (#options.options * rowHeight) + 6

				Dropdown["1"].MouseButton1Click:Connect(function()
					Dropdown.Open = not Dropdown.Open
					if Dropdown.Open then
						Library:tween(Dropdown["1"], {Size = UDim2.new(1, 0, 0, expandedHeight)})
						Library:tween(Dropdown["6"], {Rotation = 180})
					else
						Library:tween(Dropdown["1"], {Size = UDim2.new(1, 0, 0, collapsedHeight)})
						Library:tween(Dropdown["6"], {Rotation = 0})
					end
				end)
			end

			return Dropdown
		end

		-- Element: Toggle
		function Tab:Toggle(options)
			options = Library:validate({
				name = "Toggle",
				default = false,
				callback = function(value) end
			}, options or {})

			local Toggle = {
				Value = options.default and true or false
			}

			do
				Toggle["1"] = Instance.new("TextButton", Tab["1b"])
				Toggle["1"].BorderSizePixel = 0
				Toggle["1"].BackgroundColor3 = Color3.fromRGB(32, 32, 32)
				Toggle["1"].Size = UDim2.new(1, 0, 0, 32)
				Toggle["1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle["1"].Name = "Toggle"
				Toggle["1"].Text = ""
				Toggle["1"].AutoButtonColor = false

				Toggle["2"] = Instance.new("UICorner", Toggle["1"])
				Toggle["2"].CornerRadius = UDim.new(0, 4)

				Toggle["3"] = Instance.new("UIStroke", Toggle["1"])
				Toggle["3"].Thickness = 0.5
				Toggle["3"].Color = Color3.fromRGB(71, 71, 71)
				Toggle["3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				Toggle["4"] = Instance.new("TextLabel", Toggle["1"])
				Toggle["4"].BorderSizePixel = 0
				Toggle["4"].TextSize = 14
				Toggle["4"].TextXAlignment = Enum.TextXAlignment.Left
				Toggle["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle["4"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Toggle["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
				Toggle["4"].BackgroundTransparency = 1
				Toggle["4"].Size = UDim2.new(1, -26, 1, 0)
				Toggle["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle["4"].Text = options.name
				Toggle["4"].Name = "Title"

				Toggle["5"] = Instance.new("UIPadding", Toggle["1"])
				Toggle["5"].PaddingTop = UDim.new(0, 6)
				Toggle["5"].PaddingRight = UDim.new(0, 6)
				Toggle["5"].PaddingLeft = UDim.new(0, 6)
				Toggle["5"].PaddingBottom = UDim.new(0, 6)

				Toggle["6"] = Instance.new("Frame", Toggle["1"])
				Toggle["6"].BorderSizePixel = 0
				Toggle["6"].BackgroundColor3 = Color3.fromRGB(57, 57, 57)
				Toggle["6"].AnchorPoint = Vector2.new(1, 0.5)
				Toggle["6"].Size = UDim2.new(0, 16, 0, 16)
				Toggle["6"].Position = UDim2.new(1, 0, 0.5, 0)
				Toggle["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle["6"].Name = "CheckmarkHolder"

				Toggle["7"] = Instance.new("UICorner", Toggle["6"])
				Toggle["7"].CornerRadius = UDim.new(0, 2)

				Toggle["8"] = Instance.new("UIStroke", Toggle["6"])
				Toggle["8"].Thickness = 1.5
				Toggle["8"].Color = Color3.fromRGB(71, 71, 71)

				Toggle["9"] = Instance.new("ImageLabel", Toggle["6"])
				Toggle["9"].BorderSizePixel = 0
				Toggle["9"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle["9"].ImageTransparency = 1
				Toggle["9"].AnchorPoint = Vector2.new(0.5, 0.5)
				Toggle["9"].Image = "rbxassetid://116790468635619"
				Toggle["9"].Size = UDim2.new(1, -2, 1, -2)
				Toggle["9"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle["9"].BackgroundTransparency = 1
				Toggle["9"].Name = "Checkmark"
				Toggle["9"].Position = UDim2.new(0.5, 0.5, 0.5)
			end

			local function refresh()
				if Toggle.Value then
					Library:tween(Toggle["6"], {BackgroundColor3 = Color3.fromRGB(107, 170, 218)})
					Library:tween(Toggle["8"], {Color = Color3.fromRGB(76, 199, 255)})
					Library:tween(Toggle["9"], {ImageTransparency = 0})
				else
					Library:tween(Toggle["6"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
					Library:tween(Toggle["8"], {Color = Color3.fromRGB(71, 71, 71)})
					Library:tween(Toggle["9"], {ImageTransparency = 1})
				end
			end

			function Toggle:Set(value)
				Toggle.Value = value and true or false
				refresh()
				options.callback(Toggle.Value)
			end

			function Toggle:SetCallback(fn)
				options.callback = fn
			end

			Toggle["1"].MouseButton1Click:Connect(function()
				Toggle:Set(not Toggle.Value)
			end)

			refresh()

			return Toggle
		end

		return Tab
	end

	return GUI
end

return Library
