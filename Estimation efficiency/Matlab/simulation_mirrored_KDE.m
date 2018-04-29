Model =1:5;
Mlength=length(Model);
OUT = zeros(7*Mlength,3);

   


for i =1:Mlength
 model = Model(i)
   for j =1:7
        n=400+400*j
        out =computemse1_5(model,n,250)
        OUT((i-1)*7+j,:) = [model, n, out];
   end
end
OUT

save('mirroredKDE','OUT')