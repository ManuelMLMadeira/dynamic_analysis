function ComputeBodyProperties()

global Body NBody

bodymass = 51; %according to files provided

for i = 1:NBody
    Body(i).mass = Body(i).mass*bodymass;
    Body(i).inertia = Body(i).mass*(Body(i).rg*Body(i).Length)^2;
end

end