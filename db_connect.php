<html>
 <head>
 <title>Hood Chat</title>
 </head>
  <body>
  <div class="cssstyle">
 <?php
 $servername = "localhost";
$username = "root";
$password = "";
$dbname = "nextdoor";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
//create_thread($conn,2);
function create_thread($conn,$user_id)
{
	$stmt = $conn->prepare("INSERT INTO thread (u_id, thread_title, category,  initial_msg) VALUES (?, ?, ?, ?)");
	$stmt->bind_param('isss',$user_id, $threadTitle, $category,$initial_msg);
	$threadTitle='FREE Bagels for NYU';
	$category='Food';
	$initial_msg='Bagels for Students';
	if (!$stmt->execute()) {
    trigger_error('Error executing MySQL query: ' . $stmt->error);
	}
	$stmt=$conn->prepare("Select thread_id from thread where u_id=? order by creation_time DESC LIMIT 1");
	$stmt->bind_param('i',$user_id);
	$stmt->execute();
	$visibility='S';
	$thread_id = $stmt->get_result()->fetch_array(MYSQLI_ASSOC)['thread_id'];
	$receiver_email="pchaudhary@nyu.edu";
	$stmt=$conn->prepare("Select u_id from user where email=?");
	$stmt->bind_param('s',$receiver_email);
	$stmt->execute();
	$receiver_id = $stmt->get_result()->fetch_array(MYSQLI_ASSOC)['u_id'];
	print $receiver_id;
	$msg_body="I am rewa";
	//create_message($conn, $user_id, $thread_id, $msg_body);
	$stmt=$conn->prepare("INSERT INTO thread_receiver (sender_id, receiver_id, thread_id) VALUES (?, ?, ?)");
	$stmt->bind_param('iis',$user_id, $user_id, $thread_id);
	$stmt->execute();
	$stmt=$conn->prepare("INSERT INTO thread_receiver (sender_id, receiver_id, thread_id) VALUES (?, ?, ?)");
	$stmt->bind_param('iis',$user_id, $receiver_id, $thread_id);
	$stmt->execute();
	echo $stmt->affected_rows;
	$stmt->close();
} 
function post_message($conn, $user_email, $thread_id, $msg_body)
{
	$stmt=$conn->prepare("Select u_id from user where email=?");
	$stmt->bind_param('s',$user_email);
	$stmt->execute();
	$user_id = $stmt->get_result()->fetch_array(MYSQLI_ASSOC)['u_id'];
	if($stmt = $conn->prepare("INSERT INTO message (u_id, thread_id, msg_body) VALUES (?, ?, ?)"))
	{
		$stmt->bind_param('iss',$user_id, $thread_id, $msg_body);
	if (!$stmt->execute()) 
	{
		trigger_error('Error executing MySQL query: ' . $stmt->error);
	}
	}
	else
	{
		//error !! don't go further
		var_dump($conn->error);
	}
	$stmt->close();
}

function create_message($conn,$sender_email,$receiver_email,$msg_body)
{
	$stmt=$conn->prepare("Select u_id from user where email=?");
	$stmt->bind_param('s',$sender_email);
	$stmt->execute();
	$sender_id = $stmt->get_result()->fetch_array(MYSQLI_ASSOC)['u_id'];
	$stmt=$conn->prepare("SELECT u_id from user where email=?");
	$stmt->bind_param('s',$receiver_email);
	$stmt->execute();
	$receiver_id=$stmt->get_result()->fetch_array(MYSQLI_ASSOC)['u_id'];
	if($stmt = $conn->prepare("INSERT INTO personal_message (sender_id, receiver_id, msg_body, timestamp) VALUES (?, ?, ?, NOW())"))
	{
		$stmt->bind_param('iis',$sender_id, $receiver_id, $msg_body);
	if (!$stmt->execute()) 
	{
		trigger_error('Error executing MySQL query: ' . $stmt->error);
	}
	}
	else
	{
		//error !! don't go further
		var_dump($conn->error);
	}
	$stmt->close();
}
//list_new_thread_msg($conn, 1);
function list_new_thread_msg($conn, $user_id)
{
	$stmt=$conn->prepare("SELECT last_login_time from user where u_id=?");
	$stmt->bind_param('i',$user_id);
	$stmt->execute();
	$time=$stmt->get_result()->fetch_array(MYSQLI_ASSOC)['last_login_time'];
	$stmt=$conn->prepare("SELECT thread_id from thread_receiver where receiver_id=?");
	$stmt->bind_param('i',$user_id);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($thread_id);
	while($stmt->fetch())
	{	
		print $thread_id;
		$count =count_thread_msg($conn, $thread_id, $time);
		print $count;
	}
	/*foreach($thread_id as $t)
	{
		print $t;
	}*/
	$stmt->close();
}

function count_thread_msg($conn, $thread_id, $time)
{
	if($stmt=$conn->prepare("SELECT COUNT(msg_id) from message where thread_id=? and time_stamp>?"))
		{
		$stmt->bind_param('is',$thread_id,$time);
		$stmt->execute();
		//$count=$stmt->row_Count();
		$count=$stmt->get_result()->fetch_array(MYSQLI_ASSOC)['COUNT(msg_id)'];
		print "count:  ";
		//print $count;
		}
		else
		{var_dump($conn->error);}
		$stmt->close();
	return $count;
}
//list_new_personal_msg($conn,1);
function list_new_personal_msg($conn,$user_id)
{
	$stmt=$conn->prepare("SELECT last_login_time from user where u_id=?");
	$stmt->bind_param('i',$user_id);
	$stmt->execute();
	$time=$stmt->get_result()->fetch_array(MYSQLI_ASSOC)['last_login_time'];
	$stmt=$conn->prepare("SELECT DISTINCT sender_id from personal_message where timestamp>?");
	$stmt->bind_param('i',$time);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($sender_id);
	while($stmt->fetch())
	{
		print $sender_id;
		count_personal_msg($conn, $sender_id, $time);
	}
}

function count_personal_msg($conn, $sender_id, $time)
{
	if($stmt=$conn->prepare("SELECT COUNT(msg_id) from personal_message where sender_id=? and timestamp>?"))
	{$stmt->bind_param('is',$sender_id, $time);
	$stmt->execute();
	$count=$stmt->get_result()->fetch_array(MYSQLI_ASSOC)['COUNT(msg_id)'];
	print "count:  ";
	print $count;}
	else{var_dump($conn->error);}
}
function search_by_word($conn, $word, $user_id)
{
	$stmt->$conn->prepare("SELECT thread_id from thread_receiver where receiver_id=?");
	$stmt->bind_param('i',$user_id);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($thread_id);
	while($stmt->fetch())
	{
		$msg_id=chk_pattern_msg($conn,$thread_id,$word);
		print msg_id;
	}
}

function chk_pattern_msg($conn,$thread_id,$word)
{
	$stmt=$conn->prepare("SELECT msg_id from message where thread_id=? and msg_body like %?%")
	$stmt->bind_param('is',$thread_id,$word);
	$stmt->execute();
	$stmt->bind_result($msg_id);
	return msg_id;
}

$sql = "SELECT u_id, first_name, last_name FROM user";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "id: " . $row["u_id"]. " - Name: " . $row["first_name"]. " " . $row["last_name"]. "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>
</div>
 </body>
</html>