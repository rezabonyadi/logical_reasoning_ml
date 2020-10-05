function visualizer(data)
[x,y,z] = meshgrid(1:size(data,2), 1:size(data,1), 1:size(data,3));
p = patch(isosurface(x,y,z,data,0));
isonormals(x,y,z,data,p)
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud
