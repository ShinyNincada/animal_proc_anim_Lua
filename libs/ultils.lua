-- Constants
local PI = math.pi
local TWO_PI = 2 * PI

-- Simplify the angle to be in the range [0, 2π)
function simplifyAngle(angle)
  while angle >= TWO_PI do
    angle = angle - TWO_PI
  end

  while angle < 0 do
    angle = angle + TWO_PI
  end

  return angle
end

-- How many radians you need to turn the angle to match the anchor
function relativeAngleDiff(angle, anchor)
  -- Rotate coordinate space so that PI is at the anchor
  angle = simplifyAngle(angle + PI - anchor)
  anchor = PI

  return anchor - angle
end

-- Constrain the angle to be within a certain range of the anchor
function constrainAngle(angle, anchor, constraint)
  if math.abs(relativeAngleDiff(angle, anchor)) <= constraint then
    return simplifyAngle(angle)
  end

  if relativeAngleDiff(angle, anchor) > constraint then
    return simplifyAngle(anchor - constraint)
  end

  return simplifyAngle(anchor + constraint)
end
