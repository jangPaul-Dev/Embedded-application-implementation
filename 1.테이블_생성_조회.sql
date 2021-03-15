--테이블 삭제
DROP TABLE guest;
DROP TABLE extraService;
DROP TABLE room;
DROP TABLE reservation;

--system에 권한부여를 위해서 아래를 실행하고 스키마를 따로 만들어주세요!
CREATE USER esghotel IDENTIFIED BY esghotel DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO esghotel;
GRANT CREATE VIEW, CREATE SYNONYM TO esghotel;
ALTER USER esghotel ACCOUNT UNLOCK;


--esghotel 데이터 추가
--손님정보-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE guest(
		     gno VARCHAR2(5) CONSTRAINT guest_pk PRIMARY KEY NOT NULL	--고객번호 pk(default)
		   , gname VARCHAR2(20) NOT NULL				                --고객명
		   , gpnum VARCHAR2(20) NOT NULL			                    --연락처
		   , gmship NUMBER(1)					                        --멤버쉽
		   , gpay VARCHAR2(16)				                            --*? 입력받을 신용카드 0000-0000-0000-0000
		   , email varchar2(255)										--요구사항반영(12/27) 이메일개코드추가
);



--안내 COMMENT
COMMENT ON COLUMN "GUEST"."GNO" IS '고객번호';
COMMENT ON COLUMN "GUEST"."GNAME" IS '고객명';
COMMENT ON COLUMN "GUEST"."GPNUM" IS '핸드폰번호';
COMMENT ON COLUMN "GUEST"."GMSHIP" IS '멤버십';
COMMENT ON COLUMN "GUEST"."GPAY" IS '신용카드';
COMMENT ON COLUMN "GUEST"."EMAIL" IS '이메일';
--이메일

--시퀀스 생성
CREATE SEQUENCE GNO INCREMENT BY 1 MINVALUE 10000 MAXVALUE 99999 CYCLE NOCACHE ORDER ;

--손님 추가 데이터 예시
INSERT INTO GUEST (GNO, GNAME, GPNUM, GMSHIP, GPAY) 
     VALUES (gno.nextval, '홍진영','01000112222',1,'1234567891234567');


--부가서비스-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE extraService(
          eno VARCHAR2(5) CONSTRAINT extra_pk  PRIMARY KEY NOT NULL           --부가서비스 pk(default)
         , ename VARCHAR2(50)                                                --부가서비스명
         , eprice NUMBER(20)                                          --1회 이용금액
);

COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."ENO" IS '서비스번호';
COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."ENAME" IS '서비스명';
COMMENT ON COLUMN "ESGHOTEL"."EXTRASERVICE"."EPRICE" IS '1회 이용금액';


--부가서비스 관련금액
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC1','헬스',10000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC2','수영',35000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('SC3','스파',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM1','안심크림소스스테이크',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM2','활전복구이',35000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('RM3','모둠치즈플레이트',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN1','루이뢰더러_브륏_프리미어_와인',250000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN2','고디바초콜렛',50000);
INSERT INTO ESGHOTEL.EXTRASERVICE (ENO,ENAME,EPRICE) VALUES ('MN3','건크랜베리너트',30000);



--객실정보------------------------------------------------------------------------------------------------------------------------
CREATE TABLE room(
          rno VARCHAR2(4) CONSTRAINT room_pk  PRIMARY KEY  NOT NULL             --객실넘버
         , rtype VARCHAR2(20)                                                    --객실등급
          , rcap NUMBER(2)                                                        --수용인원
         , smokeyn  VARCHAR2(4)                                                  --흡연/비흡연여부
         , rprice NUMBER(10)                                                     -- 1박기준 방금액
);

--룸DB
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0001','패밀리스위트',4,'N',1990000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0102','디럭스더블',2,'N',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0103','디럭스더블',2,'Y',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0201','슈페리얼더블',3,'N',129000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0202','슈페리얼트윈',2,'Y',139000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0104','디럭스더블',2,'Y',99000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0002','패밀리스위트',4,'Y',2000000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0301','스위트',2,'N',350000);
INSERT INTO ESGHOTEL.ROOM (RNO,RTYPE,RCAP,SMOKEYN,RPRICE) VALUES ('0302','스위트',2,'Y',360000);


--예약정보------------------------------------------------------------------------------------------------------------------------
DROP TABLE reservation2;

CREATE TABLE reservation2(
            rsvcheckIn date               --입실날짜
            , 'YYYYMMDD'              --입실날짜
           , rsvcheckout date          --퇴실날짜
);



INSERT INTO ESGHOTEL.RESERVATION (RSVNO, RSVCHECKIN, RSVCHECKOUT, RSVPERSON, GNO, RNO) 
VALUES (RSVNO.nextval,'20201225' ,'20201225' ,4,'90441','0001');


CREATE TABLE reservation(
          rsvno VARCHAR2(5) CONSTRAINT rsv_pk  PRIMARY KEY  NOT NULL     --예약번호 pk(default)
         , rsvcheckIn   DATE                                          --입실날짜
         , rsvcheckout  DATE                                      --퇴실날짜
         , rsvperson    NUMBER   (2)                                        -- 입실가능 인원
         --, rsvtotal    NUMBER (10)                                      -- 날짜 * 방금액  = 최종 이용객실금액
         , gno VARCHAR2(5)
         , rno VARCHAR2(4)
         , CONSTRAINT guest_res_fk FOREIGN KEY(gno) REFERENCES guest(gno)   --게스트정보
          , CONSTRAINT room_res_fk FOREIGN KEY(rno) REFERENCES room(rno)   --객실정보
);


--rsvtotal - 이건 아무래도 영수증쪽에서나 사용할거 같아서 제생각엔 굳이 컬럼으로 둘필요 없다고 생각합니당.
--필요하다고 생각되시면 저한테 알려주세요! 혹시몰라서 주석처리 위에 해뒀습니다.
DROP 
--(VIEW 테이블)날짜 * 방금액  = 최종 이용객실금액
CREATE VIEW rsvtotal
AS SELECT GNAME 
       , (TO_CHAR(TO_DATE(RSVCHECKOUT,'YYYY-MM-DD') - TO_DATE(RSVCHECKIN, 'YYYY-MM-DD'))*RPRICE) 합산
FROM RESERVATION 
JOIN GUEST USING (GNO)
JOIN ROOM USING (RNO);

SELECT * FROM RSVTOTAL WHERE GNAME = '장주옥';

-- 실제로 조회시 사용할 쿼리
SELECT * FROM ESGHOTEL.rsvtotal;


--예약 시퀀스 생성
CREATE SEQUENCE ESGHOTEL.RSVNO INCREMENT BY 1 MINVALUE 1000 MAXVALUE 9999 CYCLE NOCACHE ORDER ;

--예약데이터 추가예시
INSERT INTO ESGHOTEL.RESERVATION (RSVNO, RSVCHECKIN,RSVCHECKOUT,RSVPERSON,GNO,RNO) 
    VALUES (RSVNO.nextval, to_DATE('20201225','yyyymmdd'),to_DATE('20201226','yyyymmdd'),4,'74040','0001');

COMMIT;

SELECT RSVCHECKIN FROM ESGHOTEL.RESERVATION;
   
--예약데이터(임시데이터)
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



--예약가능한 테이블만 보는 VIEW 테이블

CREATE VIEW forrsvtotal
AS SELECT ROOM.RNO 객실번호
     ,RTYPE 객실등급
     ,SMOKEYN 흡연여부
     ,RPRICE 객실이용금액
     ,RSVCHECKIN 체크인
     ,RSVCHECKOUT 체크아웃
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

	
--view 생성                                     
CREATE VIEW forrsvtotal
AS SELECT r.RNO 객실번호
	  ,RTYPE 객실등급
      ,RCAP 수용인원	  
      ,SMOKEYN 흡연여부
	  ,RPRICE 객실이용금액
  FROM room r,RESERVATION rsv
 WHERE r.rno=rsv.rno(+);


--view 생성                                     
CREATE VIEW forrsvtotal2
AS SELECT r.RNO 객실번호
	  ,RTYPE 객실등급
      ,RCAP 수용인원	  
      ,SMOKEYN 흡연여부
	  ,RPRICE 객실이용금액
  FROM room r,RESERVATION rsv
 WHERE r.rno=rsv.rno(+);



--view 조회조건
SELECT *  FROM forrsvtotal
WHERE 흡연여부 ='N'
   AND 수용인원 >=2   
   AND 객실번호 NOT IN (SELECT 객실번호
	 				   FROM reservation  
					  WHERE (RSVCHECKIN <= '20201227'
	       			    AND RSVCHECKOUT >= '20201226'));

	       			   
--view 조회조건
SELECT DISTINCT* FROM forrsvtotal2
WHERE 흡연여부 ='N'
   AND 수용인원 >=3  
   AND 객실번호 NOT IN (SELECT 객실번호
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