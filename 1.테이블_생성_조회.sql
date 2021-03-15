--���̺� ����
DROP TABLE guest;
DROP TABLE extraService;
DROP TABLE room;
DROP TABLE reservation;

--system�� ���Ѻο��� ���ؼ� �Ʒ��� �����ϰ� ��Ű���� ���� ������ּ���!
CREATE USER esghotel IDENTIFIED BY esghotel DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO esghotel;
GRANT CREATE VIEW, CREATE SYNONYM TO esghotel;
ALTER USER esghotel ACCOUNT UNLOCK;


--esghotel ������ �߰�
--�մ�����-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE guest(
		     gno VARCHAR2(5) CONSTRAINT guest_pk PRIMARY KEY NOT NULL	--����ȣ pk(default)
		   , gname VARCHAR2(20) NOT NULL				                --����
		   , gpnum VARCHAR2(20) NOT NULL			                    --����ó
		   , gmship NUMBER(1)					                        --�����
		   , gpay VARCHAR2(16)				                            --*? �Է¹��� �ſ�ī�� 0000-0000-0000-0000
		   , email varchar2(255)										--�䱸���׹ݿ�(12/27) �̸��ϰ��ڵ��߰�
);



--�ȳ� COMMENT
COMMENT ON COLUMN "GUEST"."GNO" IS '����ȣ';
COMMENT ON COLUMN "GUEST"."GNAME" IS '����';
COMMENT ON COLUMN "GUEST"."GPNUM" IS '�ڵ�����ȣ';
COMMENT ON COLUMN "GUEST"."GMSHIP" IS '�����';
COMMENT ON COLUMN "GUEST"."GPAY" IS '�ſ�ī��';
COMMENT ON COLUMN "GUEST"."EMAIL" IS '�̸���';
--�̸���

--������ ����
CREATE SEQUENCE GNO INCREMENT BY 1 MINVALUE 10000 MAXVALUE 99999 CYCLE NOCACHE ORDER ;

--�մ� �߰� ������ ����
INSERT INTO GUEST (GNO, GNAME, GPNUM, GMSHIP, GPAY) 
     VALUES (gno.nextval, 'ȫ����','01000112222',1,'1234567891234567');


--�ΰ�����-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE extraService(
          eno VARCHAR2(5) CONSTRAINT extra_pk  PRIMARY KEY NOT NULL           --�ΰ����� pk(default)
         , ename VARCHAR2(50)                                                --�ΰ����񽺸�
         , eprice NUMBER(20)                                          --1ȸ �̿�ݾ�
);

COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."ENO" IS '���񽺹�ȣ';
COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."ENAME" IS '���񽺸�';
COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."EPRICE" IS '1ȸ �̿�ݾ�';


--�ΰ����� ���ñݾ�
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC1','�ｺ',10000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC2','����',35000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC3','����',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM1','�Ƚ�ũ���ҽ�������ũ',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM2','Ȱ��������',35000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM3','���ġ���÷���Ʈ',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN1','���̷ڴ���_���_�����̾�_����',250000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN2','�������ݷ�',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN3','��ũ��������Ʈ',30000);



--��������------------------------------------------------------------------------------------------------------------------------
CREATE TABLE room(
          rno VARCHAR2(4) CONSTRAINT room_pk  PRIMARY KEY  NOT NULL             --���ǳѹ�
         , rtype VARCHAR2(20)                                                    --���ǵ��
          , rcap NUMBER(2)                                                        --�����ο�
         , smokeyn  VARCHAR2(4)                                                  --��/��������
         , rprice NUMBER(10)                                                     -- 1�ڱ��� ��ݾ�
);

--��DB
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0001','�йи�����Ʈ',4,'N',1990000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0102','�𷰽�����',2,'N',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0103','�𷰽�����',2,'Y',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0201','���丮�����',3,'N',129000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0202','���丮��Ʈ��',2,'Y',139000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0104','�𷰽�����',2,'Y',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0002','�йи�����Ʈ',4,'Y',2000000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0301','����Ʈ',2,'N',350000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0302','����Ʈ',2,'Y',360000);


--��������------------------------------------------------------------------------------------------------------------------------
DROP TABLE reservation2;

CREATE TABLE reservation2(
            rsvcheckIn date               --�Խǳ�¥
            , 'YYYYMMDD'              --�Խǳ�¥
           , rsvcheckout date          --��ǳ�¥
);



INSERT INTO ESGHOTEL.RESERVATION (RSVNO, RSVCHECKIN, RSVCHECKOUT, RSVPERSON, GNO, RNO) 
VALUES (RSVNO.nextval,'20201225' ,'20201225' ,4,'90441','0001');


CREATE TABLE reservation(
          rsvno VARCHAR2(5) CONSTRAINT rsv_pk  PRIMARY KEY  NOT NULL     --�����ȣ pk(default)
         , rsvcheckIn   DATE                                          --�Խǳ�¥
         , rsvcheckout  DATE                                      --��ǳ�¥
         , rsvperson    NUMBER   (2)                                        -- �Խǰ��� �ο�
         --, rsvtotal    NUMBER (10)                                      -- ��¥ * ��ݾ�  = ���� �̿밴�Ǳݾ�
         , gno VARCHAR2(5)
         , rno VARCHAR2(4)
         , CONSTRAINT guest_res_fk FOREIGN KEY(gno) REFERENCES guest(gno)   --�Խ�Ʈ����
          , CONSTRAINT room_res_fk FOREIGN KEY(rno) REFERENCES room(rno)   --��������
);


--rsvtotal - �̰� �ƹ����� �������ʿ����� ����Ұ� ���Ƽ� �������� ���� �÷����� ���ʿ� ���ٰ� �����մϴ�.
--�ʿ��ϴٰ� �����ǽø� ������ �˷��ּ���! Ȥ�ø��� �ּ�ó�� ���� �ص׽��ϴ�.
DROP 
--(VIEW ���̺�)��¥ * ��ݾ�  = ���� �̿밴�Ǳݾ�
CREATE VIEW rsvtotal
AS SELECT GNAME 
       , (TO_CHAR(TO_DATE(RSVCHECKOUT,'YYYY-MM-DD') - TO_DATE(RSVCHECKIN, 'YYYY-MM-DD'))*RPRICE) �ջ�
FROM RESERVATION 
JOIN GUEST USING (GNO)
JOIN ROOM USING (RNO);

SELECT * FROM RSVTOTAL WHERE GNAME = '���ֿ�';

-- ������ ��ȸ�� ����� ����
SELECT * FROM ESGHOTEL.rsvtotal;


--���� ������ ����
CREATE SEQUENCE ESGHOTEL.RSVNO INCREMENT BY 1 MINVALUE 1000 MAXVALUE 9999 CYCLE NOCACHE ORDER ;

--���൥���� �߰�����
INSERT INTO ESGHOTEL.RESERVATION (RSVNO, RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) 
    VALUES (RSVNO.nextval, to_DATE('20201225','yyyymmdd'),to_DATE('20201226','yyyymmdd'),4,'74040','0001');

COMMIT;

SELECT RSVCHECKIN FROM ESGHOTEL.RESERVATION;
   
--���൥����(�ӽõ�����)
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('1021',TIMESTAMP '2020-12-01 00:00:00.000000',TIMESTAMP '2012-12-04 00:00:00.000000',4,'74040','0001');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('3512',TIMESTAMP '2020-12-02 00:00:00.000000',TIMESTAMP '2020-12-03 00:00:00.000000',2,'68622','0102');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('4657',TIMESTAMP '2020-12-02 00:00:00.000000',TIMESTAMP '2020-12-03 00:00:00.000000',2,'58515','0103');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('3154',TIMESTAMP '2020-12-11 00:00:00.000000',TIMESTAMP '2020-12-12 00:00:00.000000',3,'94937','0201');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('7685',TIMESTAMP '2020-12-07 00:00:00.000000',TIMESTAMP '2020-12-09 00:00:00.000000',2,'47616','0301');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('3421',TIMESTAMP '2020-12-24 00:00:00.000000',TIMESTAMP '2020-12-25 00:00:00.000000',4,'12822','0002');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('7887',TIMESTAMP '2020-12-27 00:00:00.000000',TIMESTAMP '2020-12-28 00:00:00.000000',2,'38683','0001');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('3477',TIMESTAMP '2020-12-26 00:00:00.000000',TIMESTAMP '2020-12-28 00:00:00.000000',2,'98839','0102');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('5646',TIMESTAMP '2020-12-25 00:00:00.000000',TIMESTAMP '2020-12-29 00:00:00.000000',3,'34116','0201');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('3753',TIMESTAMP '2020-12-26 00:00:00.000000',TIMESTAMP '2020-12-27 00:00:00.000000',2,'90991','0301');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('5784',TIMESTAMP '2020-12-14 00:00:00.000000',TIMESTAMP '2020-12-16 00:00:00.000000',2,'46807','0302');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('1687',TIMESTAMP '2020-12-19 00:00:00.000000',TIMESTAMP '2020-12-21 00:00:00.000000',3,'10377','0201');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('4568',TIMESTAMP '2020-12-12 00:00:00.000000',TIMESTAMP '2020-12-19 00:00:00.000000',3,'53582','0104');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('4689',TIMESTAMP '2020-12-26 00:00:00.000000',TIMESTAMP '2020-12-30 00:00:00.000000',2,'90991','0102');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('9546',TIMESTAMP '2020-12-21 00:00:00.000000',TIMESTAMP '2020-12-28 00:00:00.000000',1,'23099','0201');
INSERT INTO ESGHOTEL.RESERVATION (RSVNO,RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) VALUES ('6735',TIMESTAMP '2020-12-25 00:00:00.000000',TIMESTAMP '2020-12-26 00:00:00.000000',1,'53582','0102');



--���డ���� ���̺� ���� VIEW ���̺�

CREATE VIEW forrsvtotal
AS SELECT ROOM.RNO ���ǹ�ȣ
     ,RTYPE ���ǵ��
     ,SMOKEYN ������
     ,RPRICE �����̿�ݾ�
     ,RSVCHECKIN üũ��
     ,RSVCHECKOUT üũ�ƿ�
  FROM room,RESERVATION  
 WHERE ROOM.rno=RESERVATION.rno(+);


   AND RCAP >= 2
   AND SMOKEYN ='N'
   AND ROOM.rno NOT IN (SELECT RESERVATION.rno 
                       FROM reservation 
                      WHERE (rsvcheckin <= '2020/12/29' 
                                       AND rsvcheckout >= '2020/12/28'));
                                      
INSERT INTO ESGHOTEL.RESERVATION (RSVNO, RSVCHECKIN, RSVCHECKOUT, RSVPERSON, GNO, RNO) 
	 VALUES (RSVNO.nextval,to_DATE('20201225','yyyymmdd'), to_DATE('20201225','yyyymmdd'),3,'32950','0001');                        

	
--view ����                                     
CREATE VIEW forrsvtotal
AS SELECT r.RNO ���ǹ�ȣ
	  ,RTYPE ���ǵ��
      ,RCAP �����ο�	  
      ,SMOKEYN ������
	  ,RPRICE �����̿�ݾ�
  FROM room r,RESERVATION rsv
 WHERE r.rno=rsv.rno(+);


--view ����                                     
CREATE VIEW forrsvtotal2
AS SELECT r.RNO ���ǹ�ȣ
	  ,RTYPE ���ǵ��
      ,RCAP �����ο�	  
      ,SMOKEYN ������
	  ,RPRICE �����̿�ݾ�
  FROM room r,RESERVATION rsv
 WHERE r.rno=rsv.rno(+);



--view ��ȸ����
SELECT *  FROM forrsvtotal
WHERE ������ ='N'
   AND �����ο� >=2   
   AND ���ǹ�ȣ NOT IN (SELECT ���ǹ�ȣ
	 				   FROM reservation  
					  WHERE (RSVCHECKIN <= '20201227'
	       			    AND RSVCHECKOUT >= '20201226'));

	       			   
--view ��ȸ����
SELECT DISTINCT* FROM forrsvtotal2
WHERE ������ ='N'
   AND �����ο� >=3  
   AND ���ǹ�ȣ NOT IN (SELECT ���ǹ�ȣ
	 				   FROM reservation  
					  WHERE (RSVCHECKIN <= '20201227'
	       			    AND RSVCHECKOUT >= '20201226'));



/*
   AND RCAP >=1   
   AND SMOKEYN ='N'
   AND r.rno NOT IN (SELECT rsv.rno 
	 					  FROM reservation  
						 WHERE (rsvcheckin <= '20201230'
	       				   AND rsvcheckout >= '2021228'));
*/
--SELECT * 
--  FROM forrsvtotal	
-- WHERE RCAP >=3



	       				  
	       				  
--ROLLBACK;
--COMMIT;