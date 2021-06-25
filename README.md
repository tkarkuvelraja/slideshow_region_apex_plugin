# Oracle APEX Plug-In: Slideshow

A plugin to display images as a responsive slideshow. Credits to **W3schools**.

Demo Application: https://apex.oracle.com/pls/apex/f?p=133110:9999::BRANCH_TO_PAGE_ACCEPT::9999:P9999_APP_PAGE_REDIRECT:6

# Prerequisite:

**DB versions:**	12.1.0.1,12.2.0.1,18.4.0.0,19.0.0.0.0,19.2.0.0.19,21.0.0.0.0,21.1.0.0.0,21.1.0.0.1

**APEX versions**	20.1.0.00.13,20.2.0.00.20,21.1.0

# Installation:

Export plugin file **"region_type_plugin_orclking_slideshow.sql"** from source directory and import it into your application.

# Steps to Achieve:

**Step 1:** Export a script **"Script to Populate Sample Data.sql"** from directory and compile it in your schema.

**Step 2:** Create a new blank page.

**Step 3:** Export plugin file **"region_type_plugin_orclking_slideshow.sql"** from Source directory and import it into your application.

**Navigation:** Shared Components ==> Plug-ins ==> Import

![image](https://user-images.githubusercontent.com/85283603/121812264-46bf0e00-cc78-11eb-842e-3e1c5671d978.png)

Plugin will be listed under plug-ins bucket after successful installation.

![image](https://user-images.githubusercontent.com/85283603/123452228-4404d700-d5ef-11eb-9798-cad30c792ddc.png)

**Step 4:** Create a region to the page. Change region type to **Slideshow [Plug-In]**.

![image](https://user-images.githubusercontent.com/85283603/123452344-6139a580-d5ef-11eb-9730-9d762e5db9ab.png)

**Step 5:**  Construct Oracle SQL query and copy and paste it in region SQL Query section.

![image](https://user-images.githubusercontent.com/85283603/123452433-76163900-d5ef-11eb-80ca-626bea80ee24.png)

**Query Template:**

    SELECT 1 slide_key,
       
           1 slide_seq,
              
           'Image 01' slide_name,
           
           'https://image.com/01' slide_url
              
      FROM dual
              
     WHERE 1 = 1;
        
       
**Sample Query to Render a Report:**

**Note:** Populate sample data by exporting a script **"Script to Populate Sample Data.sql"** from directory and compile it in your schema.

    SELECT document_id slide_key,
           
           sequence_no slide_seq,
           
           file_name slide_name,
           
           file_url slide_url
    
    FROM fxgn_documents
  
    ORDER BY sequence_no ASC;
 
 **Step 6:** Fill required attributes
 
 **1) Making Manual Slideshow:**
 
 Change the attribute **Slidshow** to **Manual**
 
 ![image](https://user-images.githubusercontent.com/85283603/123453105-2d12b480-d5f0-11eb-8bbf-945669d6f55c.png)
 
 **Output:** Then you output would display like this,
 
 ![image](https://user-images.githubusercontent.com/85283603/123453176-4451a200-d5f0-11eb-867e-e850050ece52.png)
 
  **2) Making Automatic Slideshow:**
 
 Change the attribute **Slidshow** to **Automatic**
 
 ![image](https://user-images.githubusercontent.com/85283603/123453287-66e3bb00-d5f0-11eb-9222-69621ae8e08b.png)
 
 **Output:** Then you output would display like this,
 
 ![image](https://user-images.githubusercontent.com/85283603/123453488-aca08380-d5f0-11eb-8b28-32ef1e08e84f.png)
  
That's it.

Happy APEXing!!!...

# References:

https://www.w3schools.com/howto/howto_js_slideshow.asp
