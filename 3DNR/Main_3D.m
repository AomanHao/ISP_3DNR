clear all;
close all;
videoRead = VideoReader('newfile.avi'); %��ȡ��Ƶ
nFrameRead = videoRead.NumberOfFrames;  %�����Ƶ��֡��
% vidHeightRead = videoRead.Height;       %�����Ƶ�߶�
% vidWidthRead = videoRead.width;         %�����Ƶ���
for i = 1 : nFrameRead;   %��ÿ֡ͼ�����ռ����˲�����
    %���� jpgĬ��ΪYCbCrͨ��
    strtemp = strcat('F_new',int2str(i),'.','jpg');    
    F = read(videoRead,i);
    Y = F(:,:,1);                       %���ͼ�������ͨ���ĻҶ�ֵ
    Cb = F(:,:,2);
    Cr = F(:,:,3);
%   H = fspecial('average',[3 3]); % ��ֵ�˲�����
%     H = fspecial('gaussian',[3 3],0.5); % ��˹�˲�����
%     F_Y=imfilter(Y,H,'replicate');
%     F_Cb=imfilter(Cb,H,'replicate');
%     F_Cr=imfilter(Cr,H,'replicate');  
    F_Y=medfilt2(Y,[3 3]);             %��ͼ�������ֵ�˲�����
    F_Cb=medfilt2(Cb,[3 3]);
    F_Cr=medfilt2(Cr,[3 3]);
    F_new = cat(3,F_Y,F_Cb,F_Cr);      %������ͨ��������һ�� cat����
    imwrite(F_new,strtemp,'JPG');       % ��ͼƬ���б���ΪͼƬ�ļ�
end
myobj = VideoWriter('result.avi');     % �½�һ����Ƶ�ļ�
writerObj.FrameRate =30;               % ����ÿ���֡��
open(myobj);                           % ����Ƶ�ļ�
for i = 1:nFrameRead;                  % ��ͼ������������Ƶ�ļ�
    fname = strcat('F_new',num2str(i),'.jpg');
    frame = imread(fname);
    writeVideo(myobj,frame);           
end
close(myobj);