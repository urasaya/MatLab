    for ang = 0:1:90
        nv = rx(ang)*V;
        set(p,'Vertices', nv(1:3,:)')
        drawnow
    end
    
    for ang1 = 0:1:90
        nv1 = ry(ang1)*nv;
        set(p,'Vertices', nv1(1:3,:)')
        drawnow
    end
    
    for ang2 = 0:1:90
        nv2 = rz(ang2)*nv1;
        set(p,'Vertices', nv2(1:3,:)')
        drawnow
    end
