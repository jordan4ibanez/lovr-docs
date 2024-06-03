return {
  summary = 'Set the spring parameters of the motor target.',
  description = [[
    Sets the spring parameters of the motor target.  These are similar to the spring parameters set
    by `HingeJoint:setSpring`, but they apply to the motor when it reaches its target instead of the
    angle limits of the hinge joint.  Note that these only take effect when the motor mode is
    `position`.
  ]],
  arguments = {
    frequency = {
      type = 'number',
      default = '0.0',
      description = [[
        The frequency of the spring, in hertz.  Higher frequencies make the spring more stiff.  When
        zero, the spring is disabled.
      ]]
    },
    damping = {
      type = 'number',
      default = '1.0',
      description = 'The damping ratio of the spring.'
    }
  },
  variants = {
    {
      arguments = { 'frequency', 'damping' },
      returns = {}
    }
  },
  notes = 'See `HingeJoint:setSpring` for more detailed info on how the spring parameters work.',
  related = {
    'HingeJoint:getSpring',
    'HingeJoint:setSpring',
    'HingeJoint:getMotorTarget',
    'HingeJoint:setMotorTarget'
  }
}
