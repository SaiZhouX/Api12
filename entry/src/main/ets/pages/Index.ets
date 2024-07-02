@Reusable
@Component
struct ChildComponent {
  @State desc: string = '';
  @State sum: number = 0;

  aboutToReuse(params: Record<string, Object>): void {
    this.desc = params.desc as string;
    this.sum = params.sum as number;
  }

  build() {
    Column() {
      Text('子组件' + this.desc)
        .fontSize(30)
        .fontWeight(30)
      Text('结果' + this.sum)
        .fontSize(30)
        .fontWeight(30)
    }
  }
}

@Entry
@Component
struct Reuse{
  @State sum:number = 0;
  private arr:string[] = ["1","2"];

  aboutToAppear(): void {
    this.count()
  }

  async count() {
    let temp: number = 0;
    for (let index = 0; index < 10000; index++) {
      temp += index;
    }
    // 将结果放入状态变量中
    this.sum = temp;
    console.info("this.sum = " + JSON.stringify(this.sum))
  }

  build() {
    List(){
      ForEach(this.arr, (item: string) => {
        ListItem() {
          // 子组件的传参通过状态变量进行
          ChildComponent({ desc: item, sum: this.sum })
        }
        .width('100%')
        .height(100)
      }, (item: string) => item)
    }
  }
}