void main() {
	// Create pointer to char pointing to first memory location of vid mem (top left)
	char* video_memory = (char*) 0xb8000;

	// Disply X in the top left corner
	*video_memory = 'X';
}
