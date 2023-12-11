package ShareForm;

public class ShareFormDTO {
	private String idx;
	private String title;
	private String shareofile;
	private String sharesfile;
	private String password;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String index) {
		this.idx = index;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getShareofile() {
		return shareofile;
	}

	public void setShareofile(String shareofile) {
		this.shareofile = shareofile;
	}

	public String getSharesfile() {
		return sharesfile;
	}

	public void setSharesfile(String sharesfile) {
		this.sharesfile = sharesfile;
	}
}
