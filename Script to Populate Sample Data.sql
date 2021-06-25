DROP TABLE fxgn_documents;

CREATE TABLE fxgn_documents (document_id NUMBER PRIMARY KEY, 
                             sequence_no NUMBER, 
                             file_name   VARCHAR2(240),
                             file_url    VARCHAR2(4000),
                             updated_by VARCHAR2(240), 
                             updated_on TIMESTAMP);

INSERT INTO fxgn_documents VALUES (1, 1, 'Image 1', :p_img_url,'Admin',LOCALTIMESTAMP);
INSERT INTO fxgn_documents VALUES (2, 2, 'Image 2', :p_img_url,'Admin',LOCALTIMESTAMP);
INSERT INTO fxgn_documents VALUES (3, 3, 'Image 3', :p_img_url,'Admin',LOCALTIMESTAMP);
INSERT INTO fxgn_documents VALUES (4, 4, 'Image 4', :p_img_url,'Admin',LOCALTIMESTAMP);
INSERT INTO fxgn_documents VALUES (5, 5, 'Image 5', :p_img_url,'Admin',LOCALTIMESTAMP);
INSERT INTO fxgn_documents VALUES (6, 6, 'Image 6', :p_img_url,'Admin',LOCALTIMESTAMP);

COMMIT;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT document_id slide_key,
       sequence_no slide_seq,
       file_name slide_name,
       file_url slide_url
  FROM fxgn_documents
 ORDER BY sequence_no ASC;      