function SetCondition(obj)
    import model.phy.LabCondition
    Condition=LabCondition.getCondition;
    Condition.setValue('magnetic_field', obj.parameters.MagneticField);
end