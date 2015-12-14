function lens = getLens( obj )
%GETLENS Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.Lens
    
    f=obj.parameters.FocalDistance;
    na=obj.parameters.NA;
    medium=obj.parameters.WorkingMedium;
    
    lens=Lens(f, na, medium);

end

