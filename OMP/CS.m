im = rgb2gray(imread('test02.bmp'));
d = size(im,1); %����ͼ��ԭʼ��С
x = double(im(:));%��ԭʼ��άͼ��Ϊ��λ����
n = length(x);%ԭʼ�źŴ�С
r = 4;%�����ʣ��˴�Ϊ1��4
m = floor(n/r);%������
phi = (sign(randn(m,n))+ones(m,n))/2;%����Ϊ0��1�ĸ�˹������ֲ��۲����
y = phi*x;%��ù۲���

%% ����ϡ�������ʹx=psi*s
psi = zeros(n); %����ռ�
for k = 1:n
    t = zeros(n,1);
    t(k) = 1;%s�ĵ�k��ϵ��
    t = idct(t);%��Ӧx�ķֲ�
    psi(:,k) = t;%д������
end
theta = phi*psi;
%% ���ϡ������
%%s2 = theta'*y;%��ʼ�²�
%%s1 = l1eq_pd(s2,theta,[],y,1e-3);%ʹ�� l1eq_pd���s

%% �����֪����   ��˹����
%%randn('state',7);
%%phi=sqrt(1/m)*randn(m,n);                      %Phi  ��֪����
%%y=phi*x;                                        % y   �۲�����
%%psi=inv(fft(eye(n,n)));                         % Psi ϡ�����
% Psi=dct(eye(n,n));
%%A=phi*psi;                                      % A   ��������
%%  OMP
K=25;
s1=lcf_omp(y,theta,K);

%% ת����ԭʼ�źŲ��۲�
xp = psi*s1;%��sת����ԭʼ�ź�
imRec = reshape(xp,d,d);%�������ָ�Ϊԭʼ�Ķ�άͼ��

subplot(1,2,1)
imshow(im,[]);
xlabel('original');
subplot(1,2,2)
imshow(imRec,[]);
xlabel('reconstructed')