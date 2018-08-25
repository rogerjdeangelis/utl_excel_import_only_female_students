Stackoverflow SAS: Import excel sheet that contains a string?

see stackoverflow SAS
https://tinyurl.com/y9bbwq3f
https://stackoverflow.com/questions/51986613/sas-how-to-check-if-a-column-in-an-imported-excel-sheet-contains-a-string


Faster and cleaner to do on excel side.

INPUT
=====

  d:/xls/utl_excel_reading_a_single_cell.xlsx


      +---------------------------------------------------+
      |     A      |    B       |     C      |    D       |
      +---------------------------------------------------+
   1  | NAME       |   SEX      |    AGE     |  HEIGHT    |
      +------------+------------+------------+------------+
   2  | ALFRED     |    M       |    15      |    69      |
      +------------+------------+------------+------------+
   3  | ALICE      |    F       |    13      |    56.5    |
      +------------+------------+------------+------------+
   4  | BARBARA    |    F       |    13      |    65.3    |
      +------------+------------+------------+------------+
   ...

  [CLASS]


  EXAMPLE OUTPUT  (where sex="F")
  --------------

  WORK.WANT total obs=2

      NAME      SEX    AGE    HEIGHT

     Alice       F      13     56.5
     Barbara     F      13     65.3


PROCESS
=======

proc sql dquote=ansi;
  connect to excel (Path="d:/xls/utl_excel_import_only_male_students.xlsx" mixed=yes);
    create
      table want as
    select * from connection to Excel
        (
         Select
            *
         from
            have
         where
            sex="F";
        );
    disconnect from Excel;
Quit;


OUTPUT
======

  WORK.WANT total obs=2

      NAME      SEX    AGE    HEIGHT

     Alice       F      13     56.5
     Barbara     F      13     65.3

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

%utlfkil(d:/xls/utl_excel_import_only_male_students.xlsx);

libname xel "d:/xls/utl_excel_import_only_male_students.xlsx" ;

data xel.have;
  set sashelp.class (obs=3 drop=weight);
run;quit;

libname xel clear;

