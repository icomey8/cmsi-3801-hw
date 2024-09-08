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

-- Write your say function here

-- Write your line count function here

-- Write your Quaternion table here
