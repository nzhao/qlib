function SetCondition(obj)
% Set Condition. 'magnetic_field' is obtained from the parameter file.
    import model.phy.LabCondition
    Condition=LabCondition.getCondition;
    Condition.setValue('magnetic_field', obj.parameters.MagneticField);
end