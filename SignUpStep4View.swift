HStack(spacing: 0) {
    Text("I have read and agree to the ")
    Button(action: { /* Navigate to Privacy Policy */ }) {
        Text("Privacy Policy")
            .underline()
            .foregroundColor(.black)
    }
    Text(" and ")
    Button(action: { /* Navigate to Terms & Conditions */ }) {
        Text("Terms & Conditions")
            .underline()
            .foregroundColor(.black)
    }
}
.font(.system(size: 14))
.foregroundColor(.black) 