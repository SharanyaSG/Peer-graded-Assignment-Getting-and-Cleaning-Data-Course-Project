


<div class="container-fluid main-container">




<div id="header">




</div>


<div id="codebook" class="section level1">
<h1>CODEBOOK</h1>
<p>The <strong>run_analysis.R</strong> script fulfills the following
project requirements:</p>
<ul>
<li>Merges the training and the test sets to create one data set.<br>
</li>
<li>Extracts only the measurements on the mean and standard deviation
for each measurement.<br>
</li>
<li>Uses descriptive activity names to name the activities in the data
set.<br>
</li>
<li>Appropriately labels the data set with descriptive variable
names.<br>
</li>
<li>From the data set in step 4, creates a second, independent tidy data
set with the average of each variable for each activity and each
subject.</li>
</ul>
<p><strong>Note:</strong> I loaded the required libraries, read data
from tables and assigned column names in the tables before writing and
editing scripts to respond to the project requirements.</p>
<div id="prepare-data" class="section level3">
<h3>PREPARE DATA</h3>
<ul>
<li>Step 1 - Check if archive exists.</li>
<li>Step 2 - Check if the required folder exists.</li>
</ul>
</div>
<div id="read-data-and-assign-column-names" class="section level3">
<h3>READ DATA AND ASSIGN COLUMN NAMES</h3>
<ul>
<li>Step 1 - Read and assign column names to table in the activity label
file.</li>
<li>Step 2 - Read and assign column names to table in the feature
file.</li>
<li>Step 3 - Read and assign column names to all tables under the Test
file.</li>
<li>Step 4 - Read and assign column names to all tables under the Train
file.</li>
</ul>
</div>
<div id="response-to-project-requirements" class="section level3">
<h3>RESPONSE TO PROJECT REQUIREMENTS</h3>
<p><strong>1. REQUIREMENT 1 - Merge the training and the test sets to
create one data set.</strong></p>
<ul>
<li>Step 1 - <code>merge_X</code> merges <code>x_test</code> and
<code>x_train</code> using the <em>rbind() function</em>.</li>
<li>Step 2 - <code>merge_Y</code> merges <code>y_test</code> and
<code>y_train</code> using the <em>rbind() function</em>.<br>
</li>
<li>Step 3 - <code>merge_Subject</code> merges <code>subject_test</code>
and <code>subject_train</code> using the <em>rbind() function</em>.</li>
<li>Step 4 - <code>merge_Data</code> merges <code>merge_X</code>,
<code>merge_Y</code> and <code>merge_Subject</code> using the
<em>cbind() function</em>.</li>
</ul>
<p><strong>2. REQUIREMENT 2 - Extract only the measurements on the mean
and standard deviation for each measurement.</strong></p>
<p>Subset <code>Subject</code>,<code>ID</code> and measurements related
to the mean and standard deviation from <code>merge_Data</code> and
store in <code>First_Tidy_Data</code>.</p>
<p><strong>3. REQUIREMENT 3 - Use descriptive activity names to name the
activities in the data set </strong></p>
<p>The measurements in the <code>ID</code> column from
<code>First_Tidy_Data</code> is replaced with related activity from the
second column of the <code>Activity</code> variable.</p>
<p><strong>4. REQUIREMENT 4 - Appropriately label the data set with
descriptive variable names.</strong></p>
<p>The following columns were renamed:</p>
<ul>
<li><code>ID</code> to <code>activity</code></li>
<li><code>Acc</code> to <code>Accelerometer</code></li>
<li><code>Gyro</code> to <code>Gyroscope</code></li>
<li><code>BodyBody</code> to <code>Body</code></li>
<li><code>Mag</code> to <code>Magnitude</code></li>
</ul>
<p>Additionally,</p>
<ul>
<li>All column name characters starting with <strong>f</strong> was
replaced by <code>Frequecy</code>.<br>
</li>
<li>All column name characters starting with <strong>t</strong> was
replaced by <code>Time</code>.</li>
</ul>
<p><strong>5. REQUIREMENT 5 - From the data set in step 4, creates a
second, independent tidy data set with the average of each variable for
each activity and each subject.</strong></p>
<p>A second, independent tidy data set with the average of each variable
for each activity and each subject was exported into <strong>Tidy
Data.txt</strong>.</p>
</div>
</div>




</div>















