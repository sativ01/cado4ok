// check if the prisma client was generated
// read package.json
import packageJson from "./dist/client/package.json"

async function main() {
  if (!packageJson) {
    console.error("No prisma client generated. Run $> bunx prisma generate");
    return
  }
  packageJson.name = "prisma-client"
  Bun.write("./dist/client/package.json", JSON.stringify(packageJson, null, 2))

}

main();
