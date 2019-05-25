
import sys

if __name__ == "__main__":
    with open('test.txt', 'w') as f:
        for i in range(1, 200):
            f.write(f"**{i}. **\n\n")
