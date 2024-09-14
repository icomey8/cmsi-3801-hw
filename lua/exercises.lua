function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(strings, predicate)
  for index, str in ipairs(strings) do
    if predicate(str) then
      return string.lower(str)
    end
  end
  return nil
end

-- Write your powers generator here
function powers_generator(base, limit)
    return coroutine.create(function()
        local value = 1
        local exponent = 0
        while value <= limit do
            coroutine.yield(value)
            exponent = exponent + 1
            value = base ^ exponent
        end
    end)
end
-- Write your say function here
function say(word)
  local words = {}
  local function addWord(str)
  if str then
    table.insert(words, str)
    return addWord
  else
    return table.concat(words, " ")
  end
  end

  if word then
    return addWord(word)
  else
    return ""
  end
end

-- Write your line count function here
function meaningful_line_count(file)
  local count = 0
  local f, err = io.open(file, "r")
  if not f then
    error("File not found: " .. err)
  end
  for line in f:lines() do
    local trimmed_line = line:match("^%s*(.-)%s*$") -- lloks funky but removes whitespace
    if trimmed_line ~= "" and trimmed_line:sub(1,1) ~= "#" then -- checks first char of first line
      count = count + 1
    end
  end
  f:close()
  return count
end

-- Write your Quaternion table here
Quaternion = {}
Quaternion.__index = Quaternion

-- Constructor
function Quaternion.new(a, b, c, d)
    local self = setmetatable({}, Quaternion)
    self.a = a or 0  -- real part
    self.b = b or 0  -- i component
    self.c = c or 0  -- j component
    self.d = d or 0  -- k component
    return self
end

-- String representation of quaternion
function Quaternion:__tostring()
    local parts = {}
    if self.a ~= 0 or (self.a == 0 and self.b == 0 and self.c == 0 and self.d == 0) then
        table.insert(parts, tostring(self.a))
    end
    if self.b ~= 0 then
        table.insert(parts, (self.b == 1 and "" or self.b == -1 and "-" or self.b) .. "i")
    end
    if self.c ~= 0 then
        table.insert(parts, (self.c == 1 and "" or self.c == -1 and "-" or self.c) .. "j")
    end
    if self.d ~= 0 then
        table.insert(parts, (self.d == 1 and "" or self.d == -1 and "-" or self.d) .. "k")
    end
    return table.concat(parts, "+"):gsub("%+%-", "-")
end

-- Conjugate of a quaternion
function Quaternion:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

-- Addition of two quaternions
function Quaternion.__add(q1, q2)
    return Quaternion.new(q1.a + q2.a, q1.b + q2.b, q1.c + q2.c, q1.d + q2.d)
end

-- Multiplication of two quaternions 
function Quaternion.__mul(q1, q2)
    return Quaternion.new(
        q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
        q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
        q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
        q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
    )
end

-- Coefficients list
function Quaternion:coefficients()
    return {self.a, self.b, self.c, self.d}
end

-- Equality check 
function Quaternion.__eq(q1, q2)
    return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

return Quaternion

