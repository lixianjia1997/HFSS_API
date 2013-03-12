function serial  = hfss_ind(fid,X , Y, Z, W, S, OD, NT,  Thickness, lead, viaen, serial, material)
    [mat colr] = hfssgetmaterial(material);       
    hfssUDP(fid, 'inductor', strcat('L', num2str(serial)), 12, {'Xpos', 'Ypos',  'Zpos', 'OD','S','NT', 'W','lead','Thickness', 'maskGrid', 'DIV', 'VIA_ENC'},...
            {X, Y, Z,   OD ,S, NT,W, lead, Thickness, '0.005', '3.2', viaen}, mat, colr, 1);     
    serial = serial + 1;