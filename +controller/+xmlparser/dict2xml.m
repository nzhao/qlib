function dict2xml( dict, filename )
%DICT2XML Summary of this function goes here
%   Detailed explanation goes here
configNode = com.mathworks.xml.XMLUtils.createDocument('config');
root = configNode.getDocumentElement;

main_elements=dict.keys;
sub_dicts=dict.values;

for k=1:dict.length
   main_tag=configNode.createElement(main_elements{k}); 
   root.appendChild(main_tag);
   
   dict_k = sub_dicts{k};
   child_elements=dict_k.keys;
   for m=1:dict_k.length
       val=dict_k(child_elements{m});
       child_tag=configNode.createElement(child_elements{m});
       
       child_tag.setAttribute('type', class(val));
       if isa(val, 'numeric')
           child_tag.appendChild(configNode.createTextNode(num2str(val)));
       elseif isa(val, 'char')
           child_tag.appendChild(configNode.createTextNode(val));
       end
       
       main_tag.appendChild(child_tag);
   end
end
xmlwrite(filename,configNode);
end

