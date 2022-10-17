package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//데이터베이스명 bbss
//사용자 bbs
//비밀번호 bbs1234
public class UserDAO {
	
	//필드
	private Connection conn;	//데이터베이스에 접근하기위한 Connection 객체 생성
	private PreparedStatement pstmt;
	private ResultSet rs; 		//어떤한 정보를 담을수 있는 객체 생성
	
	
	
	//생성자
	
	//localhost:3306: 컴퓨터에 설치된 서버
	//bbs라는 데이터베이스에 접속
	//접속이 완료가 되면 conn 객체안에 접속된 정보가 담기게 된다. 
	public UserDAO() {
		try {
			String url = "jdbc:mysql://localhost:3306/bbss?serverTimezone=Asia/Seoul";  
			String user = "bbs";
			String password = "bbs1234";
			Class.forName("com.mysql.cj.jdbc.Driver");//mysql 드라이버를 찾는다
			conn = DriverManager.getConnection(url,user,password); //DB접속
		}catch(Exception e) {
			e.printStackTrace(); //어떠한 오류가 발생했는지 출력해줌
		}
	}

	
	
	
	//데이터 베이스에 로그인하는 함수
	
	//SQL인젝션?같은 해킹기법을 방지하기위한 수단으로서 PreparedStatement를 이용해서
	//하나의 문장(쿼리문)을 미리준비해서 ?를 넣어둬서 ?에 해당하는 내용으로 매개변수로 넘어온 userID를 넣어준다
	//데이터베이스에서 현재 접속을 시도하고자하는 사용자의 아이디를 입력 받아서 그 아이디가 실제로 존재하는지 확인후
	//실제로 존재한다면 비밀번호는 뭔지 데이터베이스에서 가져오도록 한다
	//rs에 결과를 담을수있는 하나의 객체에 실행한 결과를 넣어준다
	public int login(String userID, String userPassword) {
		//user테이블에서 해당 사용유저를 가져온다
		String SQL = "select userPassword from bbs where userID = ?";  
		
		try {
			//pstmt에 SQl문장을 데이터에 삽입하는형식으로 인스턴스를 가져온다
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			//아이디가 있는경우
			//결과로 받은 userPassword(1)가 userPassowrd와 동일하다면 로그인 성공
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인성공
				}else {
					return 0; //로그인 실패(비밀번호가 틀리다)
				}
			}
			return -1; //return -1을 넣어서 아이디가 없다고 알려준다
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; //return -2는 데이터베이스 오류를 뜻한다
	}
	
	
	
	//insert 문장의 경우에는 반드시 0 이상의 값이 들어오기때문에
	//return값이 -1이 아닌경우에는 성공적으로 회원가입이 되었다는 의미
	public int join(User user) { //User클래스를 이용해서 하나의 인스턴스를(user) 만듬
		String SQL = "insert into bbs values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL); //pstmt에 인스턴스를 넣는다
			pstmt.setString(1, user.getUserID()); //user인스턴스의 getUserID()메소드
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); //해당 pstmt의 결과를 넣는다
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1 ; //데이터베이스 오류
	}
	
}








