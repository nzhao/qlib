function spin_list = xyzFileParser( filename )
%XYZFILEPARSER Summary of this function goes here
%   Detailed explanation goes here
    fileID=fopen(filename,'r');
    nspin=str2double(fgetl(fileID));
    data=textscan(fileID,'%s %f %f %f');
    fclose(fileID);

    spin_list=cell(1,nspin);
    for n=1:nspin
        name=data{1,1}{n};
        coord=[data{1,2}(n),data{1,3}(n),data{1,4}(n)];
        spin_list{n}=model.phy.Spin(name,coord);
    end

end

